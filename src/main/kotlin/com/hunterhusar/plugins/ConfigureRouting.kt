package com.hunterhusar.plugins

import com.hunterhusar.models.ApplicationConfig
import com.hunterhusar.plugins.encoders.decodeQRCode
import com.hunterhusar.plugins.encoders.encodeToString
import com.hunterhusar.plugins.encoders.generateQRCode
import io.ktor.client.*
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.html.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.html.*
import java.util.*

fun Application.configureRouting(
    bookService: BookService,
    client: HttpClient,
    config: ApplicationConfig,
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
            val books = bookService.getBooks()
            call.respond(HttpStatusCode.OK, books)
        }
        get("/processGenres") {
            bookService.processGenres()
            call.respond(HttpStatusCode.OK, "Genres processed successfully.")
        }
        get("/bibliotheca/{uuid}") {

            val uuid = call.parameters["uuid"] ?: return@get call.respondText(
                "Missing or malformed UUID",
                status = HttpStatusCode.BadRequest
            )

            // Generate QR code for the given UUID
            val qrCodeImage = generateQRCode("${config.qrCodeConfig.baseUrl}/bibliotheca/$uuid")

            val decodedQrCode = decodeQRCode(qrCodeImage)

            val book = bookService.getBook(UUID.fromString(uuid))

            call.respondHtml {
                head {
                    title("${book?.title} by ${book?.author}")
                }
                body {
                    style {
                        +printStyles // Inject the CSS styles
                    }
                    h1 {
                        +("${book?.title} by ${book?.author}")
                    }
                    img(src = "data:image/png;base64,${encodeToString("PNG", qrCodeImage)}", alt = "QR Code") {
                        attributes["style"] = "page-break-after: avoid;"
                    }
                    p {
                        a(href = "https://${decodedQrCode}") {
                            +"https://${decodedQrCode}"
                        }
                    }
                    p {
                        +"Genre: ${book?.genre}"
                    }
                    book?.cell?.takeIf { it > 0 }?.let {
                        p {
                            +"Bookshelf Cell #: $it"
                        }
                    }
                    book?.position?.takeIf { it > 0 }?.let {
                        p {
                            +"Bookshelf Position: $it"
                        }
                    }
                }


            }
        }
    }
}

val printStyles = """
        body {
            font-family: 'Times New Roman', serif;
            color: #000;
            background: #fff;
            font-size: 10pt; /* Smaller font size */
        }
        h1 {
            font-size: 14pt; /* Slightly larger font size for headers */
            margin: 10px 0;
        }
        p {
            margin: 8px 0;
            font-size: 10pt; /* Consistent font size for paragraphs */
        }
        img {
            display: block;
            margin: 0 auto;
            max-width: 80%; /* Smaller image size */
            height: auto;
            page-break-after: avoid;
        }
""".trimIndent()
