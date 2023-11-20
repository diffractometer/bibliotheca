package com.hunterhusar.plugins

import com.hunterhusar.db.BookRepository
import com.hunterhusar.plugins.BookService
import io.ktor.client.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting(
    bookService: BookService,
    client: HttpClient
) {
    routing {
        get("/") {
            call.respondText("Hunter's Bibliotheca!")
        }
        get("/books/db") {
            val books = bookService.listAll()
            call.respond(HttpStatusCode.OK, books)
        }
        get("/books") {
            val books = bookService.getBooks()
            call.respond(HttpStatusCode.OK, books)
        }
        get("/processGenres") {
            bookService.processGenres()
            call.respond(HttpStatusCode.OK, "Genres processed successfully.")
        }

    }
}