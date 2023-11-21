package com.hunterhusar

import com.hunterhusar.db.BookRepository
import com.hunterhusar.models.ApplicationConfig
import com.hunterhusar.plugins.BookService
import com.hunterhusar.plugins.configureRouting
import com.hunterhusar.plugins.connectToPostgres
import com.sksamuel.hoplite.ConfigLoaderBuilder
import com.sksamuel.hoplite.addResourceSource
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


fun main() {
    embeddedServer(Netty, port = 8080, host = "0.0.0.0", module = Application::module)
        .start(wait = true)
}

fun Application.module() {
    val config = ConfigLoaderBuilder.default()
        .addResourceSource("/development.yml")
        .build()
        .loadConfigOrThrow<ApplicationConfig>()
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
    configureRouting(bookService, client, config)
}

fun Application.configureSerialization() {
    install(ContentNegotiation) {
        json()
    }
}

