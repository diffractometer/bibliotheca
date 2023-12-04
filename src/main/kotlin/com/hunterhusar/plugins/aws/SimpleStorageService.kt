package com.hunterhusar.plugins.aws

import com.hunterhusar.models.S3Config
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider
import software.amazon.awssdk.regions.Region
import software.amazon.awssdk.services.s3.S3Client
import software.amazon.awssdk.services.s3.model.GetObjectRequest
import software.amazon.awssdk.services.s3.model.ListObjectsV2Request
import software.amazon.awssdk.services.s3.presigner.S3Presigner
import java.time.Duration

class S3(val config: S3Config)

fun S3.createPresignedUrl(objectKey: String): String {
    val presigner = S3Presigner.builder()
        .region(Region.of(config.region))
        .credentialsProvider(DefaultCredentialsProvider.create())
        .build()

    val getObjectRequest = GetObjectRequest.builder()
        .bucket(config.bucketName)
        .key(objectKey)
        .build()

    val presignedGetObjectRequest = presigner.presignGetObject {
        it.signatureDuration(Duration.ofMinutes(15))
        it.getObjectRequest(getObjectRequest)
    }

    presigner.close() // Don't forget to close the presigner to release resources

    return presignedGetObjectRequest.url().toString()
}

fun S3.listImagesFromBucket(): List<String> {
    val s3 = S3Client.builder()
        .region(Region.of(config.region))
        .credentialsProvider(DefaultCredentialsProvider.create())
        .build()

    val listObjects = ListObjectsV2Request.builder()
        .bucket(config.bucketName)
        .prefix(config.folder) // Using the folder from the S3Config, bookshelf_cells in this case
        .build()

    val response = s3.listObjectsV2(listObjects)
    s3.close() // Close the S3Client to release resources

    return response.contents().map { it.key() }.filter { key ->
        // Assuming you want to list only images, filter by image file extensions
        key.endsWith(".jpg") || key.endsWith(".png") || key.endsWith(".jpeg")
    }
}