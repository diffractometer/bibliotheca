package com.hunterhusar.db

import com.hunterhusar.models.Book
import com.hunterhusar.models.Genre
import com.hunterhusar.models.ManifestItem
import com.hunterhusar.models.ProtoBook
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.FileNotFoundException
import java.sql.Connection
import java.util.*

class BookRepository(private val connection: Connection) {

    suspend fun insertProcessedImages(imageKeys: List<String>) = withContext(Dispatchers.IO) {
        val insertQuery = "INSERT INTO processedimages (image_key) VALUES (?);"
        imageKeys.forEach { imageKey ->
            val statement = connection.prepareStatement(insertQuery)
            statement.setString(1, imageKey)
            statement.executeUpdate()
        }
    }

    suspend fun getUnprocessedImageKeys(allImageKeys: List<String>): List<String> = withContext(Dispatchers.IO) {
        // Get all image keys in one query
        val processedKeysSet = mutableSetOf<String>()

        // Query to select all cover_image_s3_url from Books table
        val query = "SELECT cover_image_s3_url FROM Books WHERE cover_image_s3_url = ANY(?);"

        val statement = connection.prepareStatement(query).apply {
            val array = connection.createArrayOf("VARCHAR", allImageKeys.toTypedArray())
            setArray(1, array)
        }

        val resultSet = statement.executeQuery()
        while (resultSet.next()) {
            processedKeysSet.add(resultSet.getString("cover_image_s3_url"))
        }

        // Return the list of keys that are not in the processedKeysSet
        allImageKeys.filter { it !in processedKeysSet }
    }

    suspend fun generatePackingManifest(): MutableList<ManifestItem> = withContext(Dispatchers.IO) {
        val query = loadQueryFromFile("sql/queries/V1__Generate_packing_manifest.sql")
        val statement = connection.prepareStatement(query)
        val resultSet = statement.executeQuery()

        val books = mutableListOf<ManifestItem>()
        while (resultSet.next()) {
            books.add(
                ManifestItem(
                    id = resultSet.getString("id"),
                    title = resultSet.getString("title"),
                    author = resultSet.getString("author"),
                    genre = resultSet.getString("genre"),
                    cell = resultSet.getInt("cell"),
                    position = resultSet.getInt("position"),
                    coverImageS3Url = resultSet.getString("cover_image_s3_url")
                )
            )
        }
        books
    }

    suspend fun insertBooks(books: List<ProtoBook>) = withContext(Dispatchers.IO) {
        books.forEach { insertBook(it) }
    }

    suspend fun insertBook(book: ProtoBook): Result<UUID?> = withContext(Dispatchers.IO) {
        runCatching {
            // Check if a book with the same title (case insensitive) or same coverImageS3Url already exists
            val checkTitleQuery = "SELECT id FROM Books WHERE LOWER(title) = LOWER(?);"
            val checkCoverQuery = "SELECT id FROM Books WHERE cover_image_s3_url = ?;"

            val checkTitleStatement = connection.prepareStatement(checkTitleQuery).apply {
                setString(1, book.title)
            }
            val checkCoverStatement = connection.prepareStatement(checkCoverQuery).apply {
                setString(1, book.coverImageS3Url)
            }

            val titleResultSet = checkTitleStatement.executeQuery()
            val coverResultSet = checkCoverStatement.executeQuery()

            if (titleResultSet.next() || coverResultSet.next()) {
                UUID.fromString(titleResultSet.getString("id"))  // or coverResultSet if needed
            } else {
                // Insert the new book
                val insertQuery = "INSERT INTO Books (id, title, author, cover_image_s3_url) VALUES (?, ?, ?, ?);"
                val bookId = UUID.randomUUID()
                val insertStatement = connection.prepareStatement(insertQuery).apply {
                    setObject(1, bookId)
                    setString(2, book.title)
                    setString(3, book.author)
                    setString(4, book.coverImageS3Url)
                }
                insertStatement.executeUpdate()
                bookId
            }
        }
    }


    suspend fun findBookById(bookId: UUID): Book? = withContext(Dispatchers.IO) {
        val query = "SELECT * FROM Books WHERE id = ?;"
        val statement = connection.prepareStatement(query)
        statement.setObject(1, bookId)
        val resultSet = statement.executeQuery()
        if (resultSet.next()) {
            val genreId = if (resultSet.getInt("genre_id") == 0) null else resultSet.getInt("genre_id")
            Book(
                id = resultSet.getString("id"),
                title = resultSet.getString("title"),
                author = resultSet.getString("author"),
                genreId = genreId,
                cell = resultSet.getInt("cell"),
                position = resultSet.getInt("position"),
                verified = resultSet.getBoolean("verified"),
                coverImageS3Url = resultSet.getString("cover_image_s3_url"),
                createdAt = resultSet.getTimestamp("created_at").toLocalDateTime(),
                updatedAt = resultSet.getTimestamp("updated_at").toLocalDateTime()
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
                val genreId = if (resultSet.getInt("genre_id") == 0) null else resultSet.getInt("genre_id")
                Book(
                    id = resultSet.getString("id"),
                    title = resultSet.getString("title"),
                    author = resultSet.getString("author"),
                    genreId = genreId,
                    cell = resultSet.getInt("cell"),
                    position = resultSet.getInt("position"),
                    verified = resultSet.getBoolean("verified"),
                    coverImageS3Url = resultSet.getString("cover_image_s3_url"),
                    createdAt = resultSet.getTimestamp("created_at").toLocalDateTime(),
                    updatedAt = resultSet.getTimestamp("updated_at").toLocalDateTime()
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
