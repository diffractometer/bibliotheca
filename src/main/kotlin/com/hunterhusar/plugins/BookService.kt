package com.hunterhusar.plugins

import com.hunterhusar.db.BookRepository
import com.hunterhusar.models.BookWebResponse
import com.hunterhusar.models.GenreResponse
import com.hunterhusar.models.openai.OpenAIResponse
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.util.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.*
import java.util.*

class BookService(
    private val db: BookRepository,
    private val client: HttpClient,
) {

    @OptIn(InternalAPI::class)
    suspend fun processGenres() = withContext(Dispatchers.IO) {
        val books = db.listAll()
        val genreList = db.getGenres().joinToString(", ") { it.name }
        for (book in books) {
            val requestBody = buildJsonObject {
                put("model", "gpt-3.5-turbo-1106")
                putJsonObject("response_format") {
                    put("type", "json_object")
                }
                putJsonArray("messages") {
                    addJsonObject {
                        put("role", "system")
                        put("content", "You are a helpful library assistant designed to output the genre of a book in JSON format. The genre should be one of the following: $genreList. Respond only with the genre of the book.")
                    }
                    addJsonObject {
                        put("role", "user")
                        put("content", "Given the title and author of this book, determine it's genre: ${book.title} by ${book.author}")
                    }
                }
            }

            val response: HttpResponse = client.post("https://api.openai.com/v1/chat/completions") {
                body = requestBody.toString()
            }

            val responseBody = response.bodyAsText()
            val openAIResponse: OpenAIResponse = Json.decodeFromString(responseBody)
            val messageContent = openAIResponse.choices.first().message.content
            val winnerResponse: GenreResponse = Json.decodeFromString(messageContent)
            val validGenres = db.getGenres().map { it.name }.toSet()

            // Find the corresponding Genre object from the database
            if (winnerResponse.genre in validGenres) {
                println("Genre: ${winnerResponse.genre}")
                val genre = db.getGenres().first { it.name == winnerResponse.genre }
                db.setGenreId(book.id, genre.id)
            } else {
                // Handle the case where the received genre is not in the list
                println("something went wrong with ${winnerResponse}")
                // throw IllegalArgumentException("Received genre is not valid: ${winnerResponse}")
            }
        }
    }

    suspend fun getBook(bookId: UUID): BookWebResponse? = withContext(Dispatchers.IO) {
        val book = db.findBookById(bookId)
        val genres = db.getGenres().associateBy { it.id }
        book?.let {
            BookWebResponse(
                title = it.title,
                author = it.author,
                genre = genres[it.genreId]?.name ?: "Unknown",
                cell = it.cell,
                position = it.position
            )
        }
    }

    suspend fun getBooks(): List<BookWebResponse> = withContext(Dispatchers.IO) {
        val books = db.listAll()
        val genres = db.getGenres().associateBy { it.id }
        return@withContext books.map { book ->
            BookWebResponse(
                title = book.title,
                author = book.author,
                genre = genres[book.genreId]?.name ?: "Unknown",
                cell = book.cell,
                position = book.position
            )
        }
    }

    suspend fun listAll() = withContext(Dispatchers.IO) {
        db.listAll()
    }
}
