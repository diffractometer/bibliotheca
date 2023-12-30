package com.hunterhusar.plugins

import com.hunterhusar.models.BibliothecaConfig
import com.hunterhusar.models.Genre
import com.hunterhusar.models.ManifestWebResponse
import com.hunterhusar.plugins.views.respondBookDetails
import com.hunterhusar.plugins.views.respondPackingManifest
import io.ktor.client.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import java.util.*

fun Application.configureRouting(
    bookService: BookService,
    client: HttpClient,
    config: BibliothecaConfig,
) {
    routing {
        get("/") {
            call.respondText("Hunter's Bibliotheca!")
        }
        get("/books/db") {
            val books = bookService.listAll()
            call.respond(HttpStatusCode.OK, books)
        }
        get("/bibliotheca") {
            val genreIdsParam = call.request.queryParameters["genreIds"]
            val genreIds = genreIdsParam?.split(",")?.mapNotNull { it.toIntOrNull() }

            val pageSizeParam = call.request.queryParameters["pageSize"]?.toIntOrNull()
            val offsetParam = call.request.queryParameters["offset"]?.toIntOrNull()

            val books = bookService.getBooks(genreIds, pageSizeParam, offsetParam)
            call.respond(HttpStatusCode.OK, books)
        }
        post("/bibliotheca/processGenres") {
            bookService.processGenresInBackground()
            call.respond(HttpStatusCode.OK, "Genres processing started...")
        }
        get("/bibliotheca/{uuid}") {
            val uuid = call.parameters["uuid"] ?: return@get call.respondText(
                "Missing or malformed UUID",
                status = HttpStatusCode.BadRequest
            )
            call.respondBookDetails(bookService, config.qrCodeConfig, UUID.fromString(uuid))
        }
        get("/bibliotheca/manifest") {
            val manifestWebResponse: ManifestWebResponse = bookService.generatePackingManifest()
            call.respondPackingManifest(manifestWebResponse, config.qrCodeConfig)
        }
        get("/bibliotheca/genres") {
            val genresResult = bookService.getGenresEndpoint()
            when {
                genresResult.isSuccess -> {
                    val genres: List<Genre> = genresResult.getOrNull() ?: listOf()
                    call.respond(HttpStatusCode.OK, genres)
                }
                else -> {
                    call.respond(HttpStatusCode.InternalServerError, "Error fetching genres")
                }
            }
        }
        post("/bibliotheca/processImages") {
            bookService.processImagesInBackground()
            call.respond(HttpStatusCode.OK, "Image processing started...")
        }
    }
}
