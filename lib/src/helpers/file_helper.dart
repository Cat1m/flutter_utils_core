import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// File helper utilities
class FileHelper {
  FileHelper._();

  /// Get application documents directory
  static Future<Directory> getDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Get temporary directory
  static Future<Directory> getTempDirectory() async {
    return await getTemporaryDirectory();
  }

  /// Get application support directory
  static Future<Directory> getAppSupportDirectory() async {
    return await getApplicationSupportDirectory();
  }

  /// Get external storage directory (Android only)
  static Future<Directory?> getExternalStorageDirectory() async {
    if (Platform.isAndroid) {
      return await getExternalStorageDirectory();
    }
    return null;
  }

  /// Check if file exists
  static Future<bool> fileExists(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

  /// Create file if not exists
  static Future<File> createFile(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
    return file;
  }

  /// Delete file
  static Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Copy file
  static Future<File?> copyFile(
      String sourcePath, String destinationPath) async {
    try {
      final source = File(sourcePath);
      if (await source.exists()) {
        return await source.copy(destinationPath);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Move file
  static Future<File?> moveFile(
      String sourcePath, String destinationPath) async {
    try {
      final source = File(sourcePath);
      if (await source.exists()) {
        final destination = await source.copy(destinationPath);
        await source.delete();
        return destination;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Read file as string
  static Future<String?> readFileAsString(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsString();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Write string to file
  static Future<bool> writeStringToFile(String filePath, String content) async {
    try {
      final file = await createFile(filePath);
      await file.writeAsString(content);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Read file as bytes
  static Future<Uint8List?> readFileAsBytes(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsBytes();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Write bytes to file
  static Future<bool> writeBytesToFile(String filePath, Uint8List bytes) async {
    try {
      final file = await createFile(filePath);
      await file.writeAsBytes(bytes);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get file size in bytes
  static Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final stat = await file.stat();
        return stat.size;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// Get file extension
  static String getFileExtension(String filePath) {
    return path.extension(filePath).toLowerCase();
  }

  /// Get file name without extension
  static String getFileNameWithoutExtension(String filePath) {
    return path.basenameWithoutExtension(filePath);
  }

  /// Get file name with extension
  static String getFileName(String filePath) {
    return path.basename(filePath);
  }

  /// Get directory path
  static String getDirectoryPath(String filePath) {
    return path.dirname(filePath);
  }

  /// Create directory
  static Future<Directory> createDirectory(String dirPath) async {
    final directory = Directory(dirPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  /// Delete directory
  static Future<bool> deleteDirectory(String dirPath) async {
    try {
      final directory = Directory(dirPath);
      if (await directory.exists()) {
        await directory.delete(recursive: true);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// List files in directory
  static Future<List<File>> listFiles(String dirPath,
      {String? extension}) async {
    try {
      final directory = Directory(dirPath);
      if (await directory.exists()) {
        final entities = await directory.list().toList();
        final files = entities.whereType<File>().toList();

        if (extension != null) {
          return files
              .where((file) => getFileExtension(file.path) == extension)
              .toList();
        }

        return files;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Get file MIME type
  static String getMimeType(String filePath) {
    final extension = getFileExtension(filePath);

    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.webp':
        return 'image/webp';
      case '.pdf':
        return 'application/pdf';
      case '.doc':
        return 'application/msword';
      case '.docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case '.xls':
        return 'application/vnd.ms-excel';
      case '.xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case '.txt':
        return 'text/plain';
      case '.json':
        return 'application/json';
      case '.xml':
        return 'text/xml';
      case '.zip':
        return 'application/zip';
      case '.mp4':
        return 'video/mp4';
      case '.mp3':
        return 'audio/mpeg';
      default:
        return 'application/octet-stream';
    }
  }

  /// Check if file is image
  static bool isImageFile(String filePath) {
    final mimeType = getMimeType(filePath);
    return mimeType.startsWith('image/');
  }

  /// Check if file is video
  static bool isVideoFile(String filePath) {
    final mimeType = getMimeType(filePath);
    return mimeType.startsWith('video/');
  }

  /// Check if file is audio
  static bool isAudioFile(String filePath) {
    final mimeType = getMimeType(filePath);
    return mimeType.startsWith('audio/');
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes >= 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    } else if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else if (bytes >= 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '$bytes bytes';
    }
  }

  /// Generate unique file name
  static String generateUniqueFileName(String originalName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = getFileExtension(originalName);
    final nameWithoutExt = getFileNameWithoutExtension(originalName);
    return '${nameWithoutExt}_$timestamp$extension';
  }

  /// Clean up temporary files
  static Future<void> cleanupTempFiles() async {
    try {
      final tempDir = await getTempDirectory();
      final files = await listFiles(tempDir.path);

      for (final file in files) {
        try {
          await file.delete();
        } catch (e) {
          // Ignore errors when deleting individual files
        }
      }
    } catch (e) {
      // Ignore cleanup errors
    }
  }

  /// Get available storage space
  static Future<int> getAvailableSpace(String dirPath) async {
    try {
      final directory = Directory(dirPath);
      if (await directory.exists()) {
        // ignore: unused_local_variable
        final stat = await directory.stat();
        // Note: This is a simplified implementation
        // In practice, you might need a platform-specific solution
        return 0; // Placeholder
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
