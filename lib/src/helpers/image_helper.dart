import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

/// Image helper utilities
class ImageHelper {
  ImageHelper._();

  /// Resize image file
  static Future<File?> resizeImage(
    String inputPath,
    String outputPath, {
    int? width,
    int? height,
    bool maintainAspectRatio = true,
  }) async {
    try {
      final inputFile = File(inputPath);
      if (!await inputFile.exists()) return null;

      final bytes = await inputFile.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return null;

      img.Image resized;
      if (width != null && height != null) {
        resized = img.copyResize(
          image,
          width: width,
          height: height,
          interpolation: img.Interpolation.linear,
        );
      } else if (width != null) {
        resized = img.copyResize(
          image,
          width: width,
          interpolation: img.Interpolation.linear,
        );
      } else if (height != null) {
        resized = img.copyResize(
          image,
          height: height,
          interpolation: img.Interpolation.linear,
        );
      } else {
        return null;
      }

      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(img.encodePng(resized));
      return outputFile;
    } catch (e) {
      return null;
    }
  }

  /// Compress image
  static Future<File?> compressImage(
    String inputPath,
    String outputPath, {
    int quality = 85,
    int? maxWidth,
    int? maxHeight,
  }) async {
    try {
      final inputFile = File(inputPath);
      if (!await inputFile.exists()) return null;

      final bytes = await inputFile.readAsBytes();
      var image = img.decodeImage(bytes);
      if (image == null) return null;

      // Resize if max dimensions are specified
      if (maxWidth != null || maxHeight != null) {
        if (maxWidth != null && image.width > maxWidth) {
          image = img.copyResize(image, width: maxWidth);
        }
        if (maxHeight != null && image.height > maxHeight) {
          image = img.copyResize(image, height: maxHeight);
        }
      }

      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(img.encodeJpg(image, quality: quality));
      return outputFile;
    } catch (e) {
      return null;
    }
  }

  /// Create thumbnail
  static Future<File?> createThumbnail(
    String inputPath,
    String outputPath, {
    int size = 150,
  }) async {
    return await resizeImage(
      inputPath,
      outputPath,
      width: size,
      height: size,
    );
  }

  /// Crop image
  static Future<File?> cropImage(
    String inputPath,
    String outputPath, {
    required int x,
    required int y,
    required int width,
    required int height,
  }) async {
    try {
      final inputFile = File(inputPath);
      if (!await inputFile.exists()) return null;

      final bytes = await inputFile.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return null;

      final cropped =
          img.copyCrop(image, x: x, y: y, width: width, height: height);

      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(img.encodePng(cropped));
      return outputFile;
    } catch (e) {
      return null;
    }
  }

  /// Rotate image
  static Future<File?> rotateImage(
    String inputPath,
    String outputPath, {
    required double angle,
  }) async {
    try {
      final inputFile = File(inputPath);
      if (!await inputFile.exists()) return null;

      final bytes = await inputFile.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return null;

      final rotated = img.copyRotate(image, angle: angle);

      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(img.encodePng(rotated));
      return outputFile;
    } catch (e) {
      return null;
    }
  }

  /// Get image dimensions
  static Future<Size?> getImageDimensions(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!await file.exists()) return null;

      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return null;

      return Size(image.width.toDouble(), image.height.toDouble());
    } catch (e) {
      return null;
    }
  }

  /// Convert image format
  static Future<File?> convertImageFormat(
    String inputPath,
    String outputPath,
    ImageFormat format,
  ) async {
    try {
      final inputFile = File(inputPath);
      if (!await inputFile.exists()) return null;

      final bytes = await inputFile.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) return null;

      final outputFile = File(outputPath);

      switch (format) {
        case ImageFormat.png:
          await outputFile.writeAsBytes(img.encodePng(image));
          break;
        case ImageFormat.jpg:
          await outputFile.writeAsBytes(img.encodeJpg(image));
          break;
        case ImageFormat.webp:
          //await outputFile.writeAsBytes(img.encodeWebP(image));
          break;
        case ImageFormat.gif:
          await outputFile.writeAsBytes(img.encodeGif(image));
          break;
      }

      return outputFile;
    } catch (e) {
      return null;
    }
  }

  /// Apply image filter
  static Future<File?> applyFilter(
    String inputPath,
    String outputPath,
    ImageFilter filter,
  ) async {
    try {
      final inputFile = File(inputPath);
      if (!await inputFile.exists()) return null;

      final bytes = await inputFile.readAsBytes();
      var image = img.decodeImage(bytes);
      if (image == null) return null;

      switch (filter) {
        case ImageFilter.grayscale:
          image = img.grayscale(image);
          break;
        case ImageFilter.sepia:
          image = img.sepia(image);
          break;
        case ImageFilter.invert:
          image = img.invert(image);
          break;
        case ImageFilter.blur:
          image = img.gaussianBlur(image, radius: 3);
          break;
        case ImageFilter.emboss:
          image = img.emboss(image);
          break;
      }

      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(img.encodePng(image));
      return outputFile;
    } catch (e) {
      return null;
    }
  }

  /// Add watermark to image
  static Future<File?> addWatermark(
    String imagePath,
    String watermarkPath,
    String outputPath, {
    WatermarkPosition position = WatermarkPosition.bottomRight,
    double opacity = 0.5,
  }) async {
    try {
      final imageFile = File(imagePath);
      final watermarkFile = File(watermarkPath);

      if (!await imageFile.exists() || !await watermarkFile.exists()) {
        return null;
      }

      final imageBytes = await imageFile.readAsBytes();
      final watermarkBytes = await watermarkFile.readAsBytes();

      final image = img.decodeImage(imageBytes);
      final watermark = img.decodeImage(watermarkBytes);

      if (image == null || watermark == null) return null;

      // Calculate position
      int x, y;
      switch (position) {
        case WatermarkPosition.topLeft:
          x = 10;
          y = 10;
          break;
        case WatermarkPosition.topRight:
          x = image.width - watermark.width - 10;
          y = 10;
          break;
        case WatermarkPosition.bottomLeft:
          x = 10;
          y = image.height - watermark.height - 10;
          break;
        case WatermarkPosition.bottomRight:
          x = image.width - watermark.width - 10;
          y = image.height - watermark.height - 10;
          break;
        case WatermarkPosition.center:
          x = (image.width - watermark.width) ~/ 2;
          y = (image.height - watermark.height) ~/ 2;
          break;
      }

      // Apply watermark
      final result = img.compositeImage(
        image,
        watermark,
        dstX: x,
        dstY: y,
        blend: img.BlendMode.overlay,
      );

      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(img.encodePng(result));
      return outputFile;
    } catch (e) {
      return null;
    }
  }

  /// Capture widget as image
  static Future<Uint8List?> captureWidget(
    GlobalKey repaintBoundaryKey, {
    double pixelRatio = 1.0,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    try {
      final RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? byteData = await image.toByteData(format: format);

      return byteData?.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }

  /// Check if file is valid image
  static Future<bool> isValidImage(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return false;

      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      return image != null;
    } catch (e) {
      return false;
    }
  }

  /// Get image file size
  static Future<int> getImageFileSize(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}

/// Image format enum
enum ImageFormat {
  png,
  jpg,
  webp,
  gif,
}

/// Image filter enum
enum ImageFilter {
  grayscale,
  sepia,
  invert,
  blur,
  emboss,
}

/// Watermark position enum
enum WatermarkPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  center,
}
