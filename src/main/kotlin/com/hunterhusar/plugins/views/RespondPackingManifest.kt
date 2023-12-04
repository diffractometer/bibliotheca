package com.hunterhusar.plugins.views

import com.hunterhusar.models.ManifestWebResponse
import com.hunterhusar.models.QRCodeConfig
import io.ktor.server.application.*
import io.ktor.server.html.*
import kotlinx.html.*

suspend fun ApplicationCall.respondPackingManifest(
    manifestWebResponse: ManifestWebResponse,
    qrCodeConfig: QRCodeConfig
) {
    respondHtml {
        head {
            title("Packing Manifest")
            style {
                +"""
                body {
                    font-family: 'Arial', sans-serif;
                    color: #333;
                    background: #f8f8f8;
                    line-height: 1.6;
                    margin: 0;
                    padding: 0;
                }
                h1 {
                    background-color: #4CAF50;
                    color: white;
                    margin: 0;
                    padding: 16px 20px;
                }
                table {
                    border-collapse: collapse;
                    width: 100%;
                    margin-top: 20px;
                }
                th, td {
                    border: 1px solid #ddd;
                    text-align: left;
                    padding: 8px;
                    width: 100px;
                }
                th {
                    background-color: #f2f2f2;
                }
                tr:nth-child(even) {
                    background-color: #f9f9f9;
                }
                tr:hover {
                    background-color: #f1f1f1;
                }
                """.trimIndent()
            }
        }
        body {
            h1 {
                +"Packing Manifest"
            }
            table {
                tr {
                    th { +"Id" }
                    th { +"Title" }
                    th { +"Author" }
                    th { +"Genre" }
                    th { +"Bookshelf Cell #" }
                    th { +"Position" }
                    th { +"Cover Image" }
                }
                manifestWebResponse.books.forEach { book ->
                    tr {
                        td {
                            a(href = "/bibliotheca/${book.id}") {
                                +book.id
                            }
                        }
                        td { +book.title }
                        td { +book.author }
                        td { +book.genre }
                        td { +book.cell.toString() }
                        td { +book.position.toString() }
                        td {
                            a(href = book.coverImageS3Url) { +book.coverImageS3Url }
                        }
                    }
                }
            }
        }
    }
}
