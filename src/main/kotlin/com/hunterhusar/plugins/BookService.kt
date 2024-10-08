package com.hunterhusar.plugins

import com.hunterhusar.db.BookRepository
import com.hunterhusar.models.*
import com.hunterhusar.models.openai.OpenAIResponse
import com.hunterhusar.openai.OpenAIVisionPreviewResponse
import com.hunterhusar.plugins.aws.S3
import com.hunterhusar.plugins.aws.createPresignedUrl
import com.hunterhusar.plugins.aws.listImagesFromBucket
import com.hunterhusar.plugins.time.humanReadable
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.util.*
import kotlinx.coroutines.*
import kotlinx.serialization.json.*
import truncate
import java.util.*
import kotlin.math.ceil

class BookService(
    private val db: BookRepository,
    private val client: HttpClient,
    private val config: BibliothecaConfig,
    private val s3: S3
) {

    suspend fun getGenresEndpoint(): Result<List<Genre>> = withContext(Dispatchers.IO) {
        runCatching {
            db.getGenres()
        }.onFailure { exception ->
            println("Error fetching genres: ${exception.message}")
        }
    }

    @OptIn(DelicateCoroutinesApi::class)
    fun processImagesInBackground() {
        GlobalScope.launch(Dispatchers.IO) { // Launch coroutine in the background
            processImages() // Call the suspending function to process images
        }
    }

    @OptIn(DelicateCoroutinesApi::class, InternalAPI::class)
    fun processImages() {
        GlobalScope.launch(Dispatchers.IO) {

            val unprocessedImageKeys = fetchUnprocessedImageKeys()
                // .take(10) // uncomment to only grab a few unprocessed images at a time
            println("unprocessedImageKeys: $unprocessedImageKeys")
            // the "chunk" is how many images we add to the process request
            unprocessedImageKeys.chunked(50).forEach { batch ->
                processBatch(batch)
            }
        }
    }

    private suspend fun fetchUnprocessedImageKeys(): List<String> {
        val imageKeys = s3.listImagesFromBucket()
        return db.getUnprocessedImageKeys(imageKeys)
    }

    private suspend fun processBatch(keys: List<String>) {
        val isTestMode = false

        val signedImageUrls = keys.map { s3.createPresignedUrl(it) }
        val requestBody = buildRequestBody(signedImageUrls)

        if (isTestMode) {
            println("Request Body for testing: $requestBody")
        } else {
            println("Request Body: $requestBody")
            val response = sendApiRequest(requestBody)
            val result = parseResponse(response, keys)

            result.onSuccess { protoBooks ->
                println("Successfully parsed protoBooks: $protoBooks")
                db.insertBooks(protoBooks) // Ensure this method can accept the list of ProtoBook
                // db.insertProcessedImages(keys)
            }.onFailure { exception ->
                println("Failed to parse response: ${exception.message}") // Log or handle error
            }
        }
    }

    private fun buildRequestBody(signedImageUrls: List<String>): JsonObject {
        return buildJsonObject {
            put("model", "gpt-4-vision-preview")
            putJsonArray("messages") {
                addJsonObject {
                    put("role", "user")
                    putJsonArray("content") {
                        addJsonObject {
                            put("type", "text")
                            put("text", config.prompt)
                        }
                        signedImageUrls.forEach { imageUrl ->
                            addJsonObject {
                                put("type", "image_url")
                                putJsonObject("image_url") {
                                    put("url", imageUrl)
                                }
                            }
                        }
                    }
                }
            }
            put("max_tokens", 300)
        }
    }

    @OptIn(InternalAPI::class)
    private suspend fun sendApiRequest(requestBody: JsonObject): String {
        val response: HttpResponse = client.post("https://api.openai.com/v1/chat/completions") {
            body = requestBody.toString()
        }
        return response.bodyAsText()
    }

    private fun parseResponse(responseBody: String, keys: List<String>): Result<List<ProtoBook>> {
        return runCatching {
            println("\n\nresponseBody: $responseBody\n\n")
            val json = Json { ignoreUnknownKeys = true }
            val openAIResponse: OpenAIVisionPreviewResponse = json.decodeFromString(responseBody)
            val openAIMessages = openAIResponse.choices.first().message.content
            println("\n\nmessageContent: $openAIMessages\n\n")

            val messageLines = openAIMessages.split("\n")
            val booksFromMessages = messageLines.zip(keys) { entry, imageKey ->
                val parts = entry.split(",", limit = 2).map { it.trim('"', ' ').trim() }
                val title = parts.getOrNull(0)?.takeIf { it != "null" }  // allows null
                val author = parts.getOrNull(1)?.takeIf { it != "null" }  // allows null
                ProtoBook(title = title, author = author, coverImageS3Url = imageKey)
            }
            booksFromMessages
        }.onFailure { exception ->
            println("Error parsing response: ${exception.message}")
        }
    }

    fun generatePackingManifest(): ManifestWebResponse = runBlocking {
        val manifest = db.generatePackingManifest()
        val books = manifest.map { book ->
            ManifestItem(
                id = book.id,
                title = book.title,
                author = book.author,
                genre = book.genre,
                cell = book.cell,
                position = book.position,
                coverImageS3Url = s3.createPresignedUrl(book.coverImageS3Url),
            )
        }
        return@runBlocking ManifestWebResponse(books = books)
    }

    @OptIn(DelicateCoroutinesApi::class)
    fun processGenresInBackground() {
        GlobalScope.launch(Dispatchers.IO) { // Launch coroutine in the background
            processGenres() // Call the suspending function to process genres
        }
    }

    @OptIn(InternalAPI::class)
    suspend fun processGenres() = withContext(Dispatchers.IO) {
        val books = db.listAll()
        val genreList = db.getGenres().joinToString(", ") { it.name }

        books
            .reversed()
            .filter { !it.title.isNullOrEmpty() && it.genreId == null }
            .forEach { book ->
                runCatching {
                    val author = book.author ?: "unknown author"
                    val title = book.title ?: "unknown title"
                    val requestBody = buildJsonObject {
                        put("model", "gpt-3.5-turbo-1106")
                        putJsonObject("response_format") {
                            put("type", "json_object")
                        }
                        putJsonArray("messages") {
                            addJsonObject {
                                put("role", "system")
                                put("content", "You are a helpful assistant designed to output JSON. Provide the genre of the book from the following list: $genreList. Do not respond with anything besides the genre always respond with only one genre.")
                            }
                            addJsonObject {
                                put("role", "user")
                                put("content", "${book.id},$title,$author")
                            }
                        }
                    }

                    println("Sending requestBody: $requestBody")
                    val response: HttpResponse = client.post("https://api.openai.com/v1/chat/completions") {
                        body = requestBody.toString()
                    }
                    val responseBody = response.bodyAsText()
                    println("\n\nReceived response: $responseBody\n\n")
                    val json = Json { ignoreUnknownKeys = true }
                    val openAIResponse: OpenAIResponse = json.decodeFromString(responseBody)
                    val messageContent = openAIResponse.choices.first().message.content
                    val winnerResponse: GenreResponse = Json.decodeFromString(messageContent)
                    println("\n\n winnerResponse: $winnerResponse\n\n")

                    processGenreResponse(book, winnerResponse)
                }.onFailure {
                    println("Error processing book: ${it.message}")
                }
            }
    }

    private suspend fun processGenreResponse(book: Book, winnerResponse: GenreResponse) {
        if (book.genreId == null) {
            val validGenres = db.getGenres().map { it.name }.toSet()
            if (winnerResponse.genre in validGenres) {
                val genre = db.getGenres().first { it.name == winnerResponse.genre }
                db.setGenreId(book.id, genre.id)
            } else {
                // TODO: add genre to db
                println("Received genre is not in the list: ${winnerResponse.genre}")
            }
        } else {
            println("Book ${book.title} by ${book.author} already has a genre assigned.")
        }
    }

    suspend fun getBook(bookId: UUID): BookWebResponse? = withContext(Dispatchers.IO) {
        val book = db.findBookById(bookId)
        val genres = db.getGenres().associateBy { it.id }
        book?.let {
            BookWebResponse(
                id = it.id,
                title = book.title?.truncate(50),
                author = book.author?.truncate(30),
                genre = genres[it.genreId]?.name ?: "Unknown",
                url = "${config.qrCodeConfig.baseUrl}/bibliotheca/${it.id}",
                uri = "/bibliotheca/${it.id}",
                coverImageS3Url = s3.createPresignedUrl(it.coverImageS3Url ?: ""), // probably should not be nullable
                cell = it.cell,
                position = it.position,
                createdAt = book.createdAt.humanReadable(),
                updatedAt = book.updatedAt.humanReadable(),
                status = if (it.verified) "Verified" else ""
            )
        }
    }

    suspend fun getBooks(
        genreIds: List<Int>? = null,
        pageSize: Int? = 10,
        offset: Int? = 0
    ): BookTableResponse = withContext(Dispatchers.IO) {
        val books = db.listAll(genreIds, pageSize, offset)
        val genres = db.getGenres().associateBy { it.id }
        val totalBooks = db.countAllBooks(genreIds)
        val totalPages = if (pageSize != null) ceil(totalBooks.toDouble() / pageSize).toInt() else 0

        val bookWebResponse = books.map { book ->

            // Handling the URL by splitting and then reconstructing with 'small' directory
            val parts = book.coverImageS3Url?.split("/")
            val coverImageUrlSmall = if (parts?.contains("bookshelf_cells") == true) {
                parts.joinToString("/") { if (it == "bookshelf_cells") "$it/small" else it }
            } else {
                book.coverImageS3Url  // or handle the error/exception case as appropriate
            }

            BookWebResponse(
                id = book.id,
                title = book.title?.truncate(50),
                author = book.author?.truncate(30),
                genre = genres[book.genreId]?.name ?: "Unknown",
                url = "${config.qrCodeConfig.baseUrl}/bibliotheca/${book.id}",
                uri = "/bibliotheca/${book.id}",
                coverImageS3Url = s3.createPresignedUrl(book.coverImageS3Url ?: ""),
                coverImageS3UrlSmall = s3.createPresignedUrl(coverImageUrlSmall ?: ""),
                cell = book.cell,
                position = book.position,
                createdAt = book.createdAt.humanReadable(),
                updatedAt = book.updatedAt.humanReadable(),
                status = if (book.verified) "Verified" else ""
            )
        }

        return@withContext BookTableResponse(
            bookWebResponse = bookWebResponse,
            page = 0,
            totalPages = totalPages
        )
    }

    suspend fun listAll() = withContext(Dispatchers.IO) {
        db.listAll()
    }
}



