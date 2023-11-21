package com.hunterhusar.db

import com.hunterhusar.models.Book
import com.hunterhusar.models.Genre
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.FileNotFoundException
import java.sql.Connection
import java.util.*

class BookRepository(private val connection: Connection) {

    suspend fun findBookById(bookId: UUID): Book? = withContext(Dispatchers.IO) {
        val query = "SELECT * FROM Books WHERE id = ?;"
        val statement = connection.prepareStatement(query)
        statement.setObject(1, bookId)
        val resultSet = statement.executeQuery()

        if (resultSet.next()) {
            Book(
                id = resultSet.getString("id"),
                title = resultSet.getString("title"),
                author = resultSet.getString("author"),
                genreId = resultSet.getInt("genre_id"),
                cell = resultSet.getInt("cell"),
                position = resultSet.getInt("position"),
                verified = resultSet.getBoolean("verified")
            )
        } else {
            null
        }
    }

    suspend fun listAll(): List<Book> = withContext(Dispatchers.IO) {
        val query = loadQueryFromFile("sql/queries/V1__Select_all_books.sql")
        val statement = connection.prepareStatement(query)
        val resultSet = statement.executeQuery()

        generateSequence {
            if (resultSet.next()) {
                Book(
                    id = resultSet.getString("id"),
                    title = resultSet.getString("title"),
                    author = resultSet.getString("author"),
                    genreId = resultSet.getInt("genre_id"),
                    cell = resultSet.getInt("cell"),
                    position = resultSet.getInt("position"),
                    verified = resultSet.getBoolean("verified")
                )
            } else {
                null
            }
        }.toList()
    }

    suspend fun getGenres(): List<Genre> = withContext(Dispatchers.IO) {
        val genres = mutableListOf<Genre>()
        val query = "SELECT id, name FROM Genres;"
        val statement = connection.prepareStatement(query)
        val resultSet = statement.executeQuery()
        while (resultSet.next()) {
            val genre = Genre(
                id = resultSet.getInt("id"),
                name = resultSet.getString("name")
            )
            genres.add(genre)
        }
        genres
    }

    suspend fun setGenreId(bookId: String, genreId: Int) = withContext(Dispatchers.IO) {
        val query = loadQueryFromFile("sql/queries/V1__Set_genre_id.sql")
        val statement = connection.prepareStatement(query)
        statement.setInt(1, genreId)
        statement.setObject(2, UUID.fromString(bookId)) // Explicitly cast bookId to UUID
        statement.executeUpdate()
    }


    private fun loadQueryFromFile(filePath: String): String {
        return this::class.java.classLoader.getResource(filePath)?.readText() ?: throw FileNotFoundException(filePath)
    }
}
