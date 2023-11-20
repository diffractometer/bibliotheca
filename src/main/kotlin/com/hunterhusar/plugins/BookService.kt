package com.hunterhusar.plugins

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import com.hunterhusar.db.BookRepository
import com.hunterhusar.models.Book
import com.hunterhusar.models.BookWebResponse
import com.hunterhusar.models.openai.OpenAIResponse
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.util.*
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.*

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

            // Validate the received genre
            val validGenres = db.getGenres().map { it.name }.toSet()
            if (winnerResponse.genre in validGenres) {
                println("winnerResponse: ${winnerResponse.genre}")
                // Find the corresponding Genre object from the database
                val genre = db.getGenres().first { it.name == winnerResponse.genre }
                db.setGenreId(book.id, genre.id)
            } else {
                println("somethign went wrong with ${winnerResponse}")
                // Handle the case where the received genre is not in the list
                // throw IllegalArgumentException("Received genre is not valid: ${winnerResponse}")
            }
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
        val books = db.listAll()
        books
    }
}

@Serializable
data class GenreResponse(
    val genre: String
)