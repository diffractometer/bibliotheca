package com.hunterhusar.models

import kotlinx.serialization.Contextual
import kotlinx.serialization.Serializable
import java.time.LocalDateTime

data class ProtoBook(
    val title: String,
    val author: String,
    val coverImageS3Url: String? = null,
)

@Serializable
data class Book(
    val id: String,
    val title: String,
    val author: String,
    val genreId: Int?,
    val cell: Int?,
    val position: Int?,
    val verified: Boolean,
    val coverImageS3Url: String? = null,
    @Contextual val createdAt: LocalDateTime,
    @Contextual val updatedAt: LocalDateTime,
)

@Serializable
data class BookWebResponse(
    val id: String,
    val title: String,
    val author: String,
    val genre: String,
    val cell: Int?,
    val position: Int?,
    val url: String? = null,
    val uri: String? = null,
    val coverImageS3Url: String? = null,
    val createdAt: String,
    val updatedAt: String,
    val status: String
)


@Serializable
data class ManifestWebResponse(
    val books: List<ManifestItem>
)

@Serializable
data class ManifestItem(
    val id: String,
    val title: String,
    val author: String,
    val genre: String,
    val coverImageS3Url: String,
    val cell: Int?,
    val position: Int?,
)