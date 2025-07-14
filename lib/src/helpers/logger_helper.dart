import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Logger helper utilities
class LoggerHelper {
  LoggerHelper._();

  static bool _isDebugMode = true;
  static String _loggerName = 'FlutterUtilsCore';

  /// Enable or disable debug mode
  static void setDebugMode(bool enabled) {
    _isDebugMode = enabled;
  }

  /// Set logger name
  static void setLoggerName(String name) {
    _loggerName = name;
  }

  /// Log debug message
  static void debug(String message, {String? tag}) {
    if (_isDebugMode) {
      _log('DEBUG', message, tag: tag);
    }
  }

  /// Log info message
  static void info(String message, {String? tag}) {
    _log('INFO', message, tag: tag);
  }

  /// Log warning message
  static void warning(String message, {String? tag}) {
    _log('WARNING', message, tag: tag);
  }

  /// Log error message
  static void error(String message,
      {Object? error, StackTrace? stackTrace, String? tag}) {
    _log('ERROR', message, tag: tag);
    if (error != null) {
      _log('ERROR', 'Error: $error', tag: tag);
    }
    if (stackTrace != null) {
      _log('ERROR', 'StackTrace: $stackTrace', tag: tag);
    }
  }

  /// Log network request
  static void logRequest(String method, String url,
      {Map<String, dynamic>? headers, dynamic body}) {
    if (_isDebugMode) {
      debug('🌐 $method $url', tag: 'NETWORK');
      if (headers != null) {
        debug('Headers: $headers', tag: 'NETWORK');
      }
      if (body != null) {
        debug('Body: $body', tag: 'NETWORK');
      }
    }
  }

  /// Log network response
  static void logResponse(int statusCode, String url,
      {dynamic body, Duration? duration}) {
    if (_isDebugMode) {
      final emoji = statusCode >= 200 && statusCode < 300 ? '✅' : '❌';
      final durationText =
          duration != null ? ' (${duration.inMilliseconds}ms)' : '';
      debug('$emoji $statusCode $url$durationText', tag: 'NETWORK');
      if (body != null) {
        debug('Response: $body', tag: 'NETWORK');
      }
    }
  }

  /// Log user action
  static void logUserAction(String action, {Map<String, dynamic>? parameters}) {
    debug('👤 User: $action', tag: 'USER_ACTION');
    if (parameters != null) {
      debug('Parameters: $parameters', tag: 'USER_ACTION');
    }
  }

  /// Log navigation
  static void logNavigation(String from, String to) {
    debug('🧭 Navigation: $from → $to', tag: 'NAVIGATION');
  }

  /// Log performance
  static void logPerformance(String operation, Duration duration) {
    debug('⏱️ $operation took ${duration.inMilliseconds}ms',
        tag: 'PERFORMANCE');
  }

  /// Log app lifecycle
  static void logAppLifecycle(String state) {
    info('📱 App lifecycle: $state', tag: 'LIFECYCLE');
  }

  /// Log authentication
  static void logAuth(String event, {String? userId}) {
    info('🔐 Auth: $event${userId != null ? ' (User: $userId)' : ''}',
        tag: 'AUTH');
  }

  /// Log cache operation
  static void logCache(String operation, String key, {bool hit = false}) {
    debug('💾 Cache $operation: $key${hit ? ' (HIT)' : ' (MISS)'}',
        tag: 'CACHE');
  }

  /// Log database operation
  static void logDatabase(String operation, String table, {int? count}) {
    debug(
        '🗄️ DB $operation: $table${count != null ? ' ($count records)' : ''}',
        tag: 'DATABASE');
  }

  /// Log file operation
  static void logFile(String operation, String path) {
    debug('📁 File $operation: $path', tag: 'FILE');
  }

  /// Time a function execution
  static T timeFunction<T>(String name, T Function() function) {
    final stopwatch = Stopwatch()..start();
    final result = function();
    stopwatch.stop();
    logPerformance(name, stopwatch.elapsed);
    return result;
  }

  /// Time an async function execution
  static Future<T> timeAsyncFunction<T>(
      String name, Future<T> Function() function) async {
    final stopwatch = Stopwatch()..start();
    final result = await function();
    stopwatch.stop();
    logPerformance(name, stopwatch.elapsed);
    return result;
  }

  /// Internal log method
  static void _log(String level, String message, {String? tag}) {
    final timestamp = DateTime.now().toString();
    final tagText = tag != null ? '[$tag] ' : '';
    final logMessage = '$timestamp [$_loggerName] [$level] $tagText$message';

    developer.log(
      message,
      time: DateTime.now(),
      level: _getLevelValue(level),
      name: _loggerName,
    );

    if (kDebugMode) {
      print(logMessage);
    }
  }

  /// Get log level value
  static int _getLevelValue(String level) {
    switch (level) {
      case 'DEBUG':
        return 500;
      case 'INFO':
        return 800;
      case 'WARNING':
        return 900;
      case 'ERROR':
        return 1000;
      default:
        return 0;
    }
  }

  /// Log object details
  static void logObject(String name, Object? object) {
    if (_isDebugMode) {
      debug('📦 $name: ${object.toString()}', tag: 'OBJECT');
    }
  }

  /// Log JSON data
  static void logJson(String name, Map<String, dynamic> json) {
    if (_isDebugMode) {
      debug('📋 $name: $json', tag: 'JSON');
    }
  }

  /// Clear logs (for debugging purposes)
  static void clear() {
    if (_isDebugMode) {
      info('🧹 Logs cleared', tag: 'SYSTEM');
    }
  }
}
