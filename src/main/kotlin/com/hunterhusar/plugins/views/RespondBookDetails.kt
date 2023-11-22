package com.hunterhusar.plugins.views

import com.hunterhusar.models.QRCodeConfig
import com.hunterhusar.plugins.BookService
import com.hunterhusar.plugins.encoders.decodeQRCode
import com.hunterhusar.plugins.encoders.encodeToString
import com.hunterhusar.plugins.encoders.generateQRCode
import io.ktor.server.application.*
import io.ktor.server.html.*
import kotlinx.html.*
import java.util.*

suspend fun ApplicationCall.respondBookDetails(
    bookService: BookService,
    qrCodeConfig: QRCodeConfig,
    uuid: UUID
) {
    val qrCodeImage = generateQRCode("${qrCodeConfig.baseUrl}/bibliotheca/$uuid")
    val book = bookService.getBook(uuid)
    val decodedQrCode = decodeQRCode(qrCodeImage)

    respondHtml {
        head {
            title("${book?.title} by ${book?.author}")
        }
        body {
            style {
                +printStyles // Inject the CSS styles
            }
            // "Back" button or link
            p {
                a(href = "/bibliotheca/manifest") {
                    +"← Back to Bibliotheca"
                }
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
