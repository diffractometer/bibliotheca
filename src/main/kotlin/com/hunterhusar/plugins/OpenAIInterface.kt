package com.hunterhusar.plugins


class OpenAIInterface(private val openaiApiKey: String) {
    // val client = HttpClient(CIO) {
    //     install(ContentNegotiation) {
    //         json(Json {
    //             prettyPrint = true
    //             isLenient = true
    //         })
    //     }
    // }
    // defaultRequest {
    //     headers {
    //         append(HttpHeaders.Authorization, "Bearer $openaiApiKey")
    //     }
    // }
}
