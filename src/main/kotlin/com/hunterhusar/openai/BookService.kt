package com.hunterhusar.openai

import kotlinx.serialization.Serializable

@Serializable
data class Choice(
    val index: Int,
    val message: Message,
    val finish_details: FinishDetails // Added this field
    // Uncomment if 'finish_reason' is expected in the response
    // val finish_reason: String? = null
)

@Serializable
data class Message(
    val role: String,
    val content: String
)

@Serializable
data class FinishDetails(
    val type: String,
    val stop: String? = null
)

@Serializable
data class Usage(
    val prompt_tokens: Int,
    val completion_tokens: Int,
    val total_tokens: Int
)

@Serializable
data class OpenAIVisionPreviewResponse(
    val id: String,
    val `object`: String,
    val created: Long,
    val model: String,
    val usage: Usage,
    val choices: List<Choice>,
)
