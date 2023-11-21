package com.hunterhusar.models

import kotlinx.serialization.Serializable

@Serializable
data class Book(
    val id: String,
    val title: String,
    val author: String,
    val genreId: Int?,
    val cell: Int?,
    val position: Int?,
    val verified: Boolean,
    val createdAt: String,
    val updatedAt: String,
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
    val createdAt: String,
    val updatedAt: String,
)