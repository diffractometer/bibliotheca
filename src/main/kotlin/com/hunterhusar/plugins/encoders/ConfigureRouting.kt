package com.hunterhusar.plugins.encoders

import com.google.zxing.BarcodeFormat
import com.google.zxing.BinaryBitmap
import com.google.zxing.LuminanceSource
import com.google.zxing.client.j2se.BufferedImageLuminanceSource
import com.google.zxing.client.j2se.MatrixToImageWriter
import com.google.zxing.common.HybridBinarizer
import com.google.zxing.qrcode.QRCodeReader
import com.google.zxing.qrcode.QRCodeWriter
import java.awt.image.BufferedImage
import java.io.ByteArrayOutputStream
import java.util.*
import javax.imageio.ImageIO

fun encodeToString(format: String, image: BufferedImage): String {
    val outputStream = ByteArrayOutputStream()
    ImageIO.write(image, format, outputStream)
    return Base64.getEncoder().encodeToString(outputStream.toByteArray())
}

fun generateQRCode(content: String): BufferedImage {
    val qrCodeWriter = QRCodeWriter()
    val bitMatrix = qrCodeWriter.encode(content, BarcodeFormat.QR_CODE, 200, 200)
    return MatrixToImageWriter.toBufferedImage(bitMatrix)
}

fun decodeQRCode(bufferedImage: BufferedImage): String {
    val source: LuminanceSource = BufferedImageLuminanceSource(bufferedImage)
    val bitmap = BinaryBitmap(HybridBinarizer(source))
    return QRCodeReader().decode(bitmap).text
}