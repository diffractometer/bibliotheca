package com.hunterhusar.models.openai

import com.hunterhusar.openai.Choice
import com.hunterhusar.openai.Usage
import kotlinx.serialization.Serializable

@Serializable
data class OpenAIResponse(
    val id: String,
    val `object`: String,
    val created: Long,
    val model: String,
    val choices: List<Choice>,
    val usage: Usage,
    val system_fingerprint: String
)