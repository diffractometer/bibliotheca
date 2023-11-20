package com.hunterhusar.plugins

import com.hunterhusar.db.BookRepository
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import java.sql.*

fun connectToPostgres(): Connection {
    Class.forName("org.postgresql.Driver")
    val url = "jdbc:postgresql://localhost:5432/bibliotheca_development"
    val user = "postgres"
    val password = "1234"

    return DriverManager.getConnection(url, user, password)
}
