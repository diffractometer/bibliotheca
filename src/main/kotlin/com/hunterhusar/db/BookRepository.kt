package com.hunterhusar.db

import com.hunterhusar.models.*
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

    suspend fun countAllBooks(genreIds: List<Int>? = null): Int = withContext(Dispatchers.IO) {
        val baseQuery = StringBuilder("SELECT COUNT(*) as total FROM Books")
        if (!genreIds.isNullOrEmpty()) {
            val genresPlaceholder = genreIds.joinToString(separator = ",", prefix = "(", postfix = ")")
            baseQuery.append(" WHERE genre_id IN $genresPlaceholder")
        }
        val statement = connection.prepareStatement(baseQuery.toString())
        val resultSet = statement.executeQuery()
        if (resultSet.next()) {
            resultSet.getInt("total")
        } else {
            0
        }
    }

    suspend fun listAll(
        genreIds: List<Int>? = null,
        pageSize: Int? = null,
        offset: Int? = null,
        sortBy: SortBy? = SortBy("title", "ASC"),
        cellWidth: Int = 16 // Default cell width for "books" per cell
    ): List<Book> = withContext(Dispatchers.IO) {
        val books = mutableListOf<Book>()

        if (!genreIds.isNullOrEmpty()) {
            // Execute the original query when genreIds are provided
            val baseQuery = StringBuilder("SELECT * FROM books WHERE genre_id IN (${genreIds.joinToString()})")

            // Add ORDER BY clause
            baseQuery.append(
                " ORDER BY " +
                        "REVERSE(SPLIT_PART(REVERSE(author), ' ', 1)) ASC, " +
                        "${sortBy?.field} ${sortBy?.direction}, " +
                        "genre_id ASC"
            )

            // Add pagination with LIMIT and OFFSET if they're provided
            if (pageSize != null && offset != null) {
                baseQuery.append(" LIMIT $pageSize OFFSET $offset")
            }

            // Prepare and execute the statement, then build the list of books
            val statement = connection.prepareStatement(baseQuery.toString())
            val resultSet = statement.executeQuery()
            while (resultSet.next()) {
                books.add(
                    Book(
                        id = resultSet.getString("id"),
                        title = resultSet.getString("title"),
                        author = resultSet.getString("author"),
                        genreId = resultSet.getInt("genre_id").takeIf { it != 0 },
                        // Ignoring cell and position fields as they are not relevant for this query
                        cell = null,
                        position = null,
                        verified = resultSet.getBoolean("verified"),
                        coverImageS3Url = resultSet.getString("cover_image_s3_url"),
                        createdAt = resultSet.getTimestamp("created_at").toLocalDateTime(),
                        updatedAt = resultSet.getTimestamp("updated_at").toLocalDateTime()
                    )
                )
            }
        } else {
            val baseQuery = StringBuilder("""
                WITH OrderedBooks AS (
                    SELECT *,
                           ROW_NUMBER() OVER (ORDER BY 
                               genre_id ASC,
                               REVERSE(SPLIT_PART(REVERSE(author), ' ', 1)) ASC,
                               ${sortBy?.field} ${sortBy?.direction}
                           ) AS rn
                    FROM books
                )
                SELECT id,
                       title,
                       author,
                       genre_id,
                       verified,
                       cover_image_s3_url,
                       created_at,
                       updated_at,
                       CEILING(rn / CAST($cellWidth AS DECIMAL)) AS cell,
                       (rn - 1) % $cellWidth + 1 AS position
                FROM OrderedBooks
            """)

            // Add WHERE clause if filtering by genreIds
            if (!genreIds.isNullOrEmpty()) {
                val genresPlaceholder = genreIds.joinToString(separator = ",", prefix = "(", postfix = ")")
                baseQuery.append(" WHERE genre_id IN $genresPlaceholder")
            }

            // Add ORDER BY clause
            // No need to add an ORDER BY clause here because it's already specified in OrderedBooks CTE.

            // Add pagination with LIMIT and OFFSET if they're provided
            if (pageSize != null && offset != null) {
                baseQuery.append(" LIMIT $pageSize OFFSET $offset")
            }

            // Prepare and execute the statement, then build the list of books
            val statement = connection.prepareStatement(baseQuery.toString())
            val resultSet = statement.executeQuery()
            while (resultSet.next()) {
                books.add(
                    Book(
                        id = resultSet.getString("id"),
                        title = resultSet.getString("title"),
                        author = resultSet.getString("author"),
                        genreId = resultSet.getInt("genre_id").takeIf { it != 0 },
                        cell = resultSet.getInt("cell"),
                        position = resultSet.getInt("position"),
                        verified = resultSet.getBoolean("verified"),
                        coverImageS3Url = resultSet.getString("cover_image_s3_url"),
                        createdAt = resultSet.getTimestamp("created_at").toLocalDateTime(),
                        updatedAt = resultSet.getTimestamp("updated_at").toLocalDateTime()
                    )
                )
            }
        }
        books
    }


    suspend fun getGenres(): List<Genre> = withContext(Dispatchers.IO) {
        val genresWithCount = mutableListOf<Genre>()
        val query = """
            SELECT g.id, g.name, COUNT(b.genre_id) as book_count
            FROM Genres g
            LEFT JOIN Books b ON g.id = b.genre_id
            GROUP BY g.id, g.name
            ORDER BY g.name;
        """
        val statement = connection.prepareStatement(query)
        val resultSet = statement.executeQuery()
        while (resultSet.next()) {
            val genre = Genre(
                id = resultSet.getInt("id"),
                name = resultSet.getString("name"),
                count = resultSet.getInt("book_count")  // Add count field to Genre class
            )
            genresWithCount.add(genre)
        }
        genresWithCount
    }

    suspend fun setGenreId(bookId: String, genreId: Int) = withContext(Dispatchers.IO) {
        runCatching {
            // sql/queries/V1__Set_genre_id.sql = UPDATE Books SET genre_id = ? WHERE id = ?;
            val query = loadQueryFromFile("sql/queries/V1__Set_genre_id.sql")
            val statement = connection.prepareStatement(query)
            statement.setInt(1, genreId)
            statement.setObject(2, UUID.fromString(bookId)) // Explicitly cast bookId to UUID
            statement.executeUpdate()
        }.onFailure { exception ->
            // Log the exception or handle it as needed
            println("Error setting genre for book ID $bookId: ${exception.message}")
        }
    }

    private fun loadQueryFromFile(filePath: String): String {
        return this::class.java.classLoader.getResource(filePath)?.readText() ?: throw FileNotFoundException(filePath)
    }
}
