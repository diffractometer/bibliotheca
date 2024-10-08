package com.hunterhusar.models

data class BibliothecaConfig(
    val env: String,
    val dbConfig: DatabaseConfig,
    val serverConfig: ServerConfig,
    val qrCodeConfig: QRCodeConfig,
    val s3Config: S3Config,
    val prompt: String
)

data class DatabaseConfig(
    val host: String,
    val port: Int,
    val user: String,
    val pass: String,
)

data class ServerConfig(
    val port: Int,
    val redirectUrl: String,
)

data class QRCodeConfig(
    val baseUrl: String,
)

data class S3Config(
    val bucketName: String,
    val region: String,
    val folder: String
)