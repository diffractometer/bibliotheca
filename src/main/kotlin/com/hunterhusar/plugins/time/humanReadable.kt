package com.hunterhusar.plugins.time

import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

fun LocalDateTime.humanReadable(): String {
    val formatter = DateTimeFormatter.ofPattern("E MMM dd hh:mm a")
    return this.format(formatter)
}