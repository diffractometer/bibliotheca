package com.hunterhusar

import com.hunterhusar.db.BookRepository
import com.hunterhusar.plugins.*
import io.ktor.client.*
import io.ktor.client.engine.cio.*
import io.ktor.client.plugins.*
import io.ktor.client.request.*
import io.ktor.http.*
import io.ktor.http.ContentType.Application.Json
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import io.ktor.server.plugins.contentnegotiation.*
import kotlinx.serialization.json.Json


fun main() {
    embeddedServer(Netty, port = 8080, host = "0.0.0.0", module = Application::module)
        .start(wait = true)
}

fun Application.module() {
    val dbConnection = connectToPostgres()
    val bookRepository = BookRepository(dbConnection)
    val openAIKey = System.getenv("OPENAI_API_KEY")
    val client = HttpClient(CIO) {
        install(DefaultRequest) {
            header(HttpHeaders.ContentType, Json)
            header(HttpHeaders.Authorization, "Bearer $openAIKey")
        }
    }
    val bookService = BookService(bookRepository, client)
    configureSerialization()
    configureRouting(bookService, client)
}

fun Application.configureSerialization() {
    install(ContentNegotiation) {
        json()
    }
}
