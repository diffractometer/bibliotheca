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
    val verified: Boolean
)

@Serializable
data class BookWebResponse(
    val title: String,
    val author: String,
    val genre: String,
    val cell: Int?,
    val position: Int?
)