import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Connectivity helper utilities
class ConnectivityHelper {
  ConnectivityHelper._();

  static final Connectivity _connectivity = Connectivity();

  /// Check if device has internet connection
  static Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }

      // Actually test internet connectivity by pinging a reliable host
      return await _testInternetConnection();
    } catch (e) {
      return false;
    }
  }

  /// Test actual internet connectivity
  static Future<bool> _testInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Get current connectivity type
  static Future<ConnectivityResult> getConnectivityType() async {
    try {
      return await _connectivity.checkConnectivity();
    } catch (e) {
      return ConnectivityResult.none;
    }
  }

  /// Check if connected via WiFi
  static Future<bool> isConnectedViaWiFi() async {
    final result = await getConnectivityType();
    return result == ConnectivityResult.wifi;
  }

  /// Check if connected via mobile data
  static Future<bool> isConnectedViaMobile() async {
    final result = await getConnectivityType();
    return result == ConnectivityResult.mobile;
  }

  /// Check if connected via ethernet
  static Future<bool> isConnectedViaEthernet() async {
    final result = await getConnectivityType();
    return result == ConnectivityResult.ethernet;
  }

  /// Get connectivity status as string
  static Future<String> getConnectivityStatus() async {
    final result = await getConnectivityType();
    final hasInternet = await hasInternetConnection();

    switch (result) {
      case ConnectivityResult.wifi:
        return hasInternet ? 'WiFi đã kết nối' : 'WiFi không có internet';
      case ConnectivityResult.mobile:
        return hasInternet
            ? 'Dữ liệu di động đã kết nối'
            : 'Dữ liệu di động không có internet';
      case ConnectivityResult.ethernet:
        return hasInternet
            ? 'Ethernet đã kết nối'
            : 'Ethernet không có internet';
      case ConnectivityResult.none:
      default:
        return 'Không có kết nối mạng';
    }
  }

  /// Listen to connectivity changes
  static Stream<ConnectivityResult> onConnectivityChanged() {
    return _connectivity.onConnectivityChanged;
  }

  /// Wait for internet connection
  static Future<void> waitForConnection({Duration? timeout}) async {
    final completer = Completer<void>();

    if (await hasInternetConnection()) {
      completer.complete();
      return completer.future;
    }

    late StreamSubscription subscription;
    Timer? timeoutTimer;

    subscription = onConnectivityChanged().listen((result) async {
      if (await hasInternetConnection()) {
        subscription.cancel();
        timeoutTimer?.cancel();
        if (!completer.isCompleted) {
          completer.complete();
        }
      }
    });

    if (timeout != null) {
      timeoutTimer = Timer(timeout, () {
        subscription.cancel();
        if (!completer.isCompleted) {
          completer
              .completeError(TimeoutException('Connection timeout', timeout));
        }
      });
    }

    return completer.future;
  }

  /// Check network speed (rough estimation)
  static Future<String> estimateNetworkSpeed() async {
    if (!await hasInternetConnection()) {
      return 'Không có kết nối';
    }

    try {
      final stopwatch = Stopwatch()..start();
      await InternetAddress.lookup('google.com');
      stopwatch.stop();

      final latency = stopwatch.elapsedMilliseconds;

      if (latency < 100) {
        return 'Tốt';
      } else if (latency < 300) {
        return 'Khá';
      } else if (latency < 600) {
        return 'Chậm';
      } else {
        return 'Rất chậm';
      }
    } catch (e) {
      return 'Không xác định';
    }
  }

  /// Get network info
  static Future<Map<String, dynamic>> getNetworkInfo() async {
    final connectivityType = await getConnectivityType();
    final hasInternet = await hasInternetConnection();
    final status = await getConnectivityStatus();
    final speed = await estimateNetworkSpeed();

    return {
      'type': connectivityType.toString(),
      'hasInternet': hasInternet,
      'status': status,
      'speed': speed,
      'isWiFi': await isConnectedViaWiFi(),
      'isMobile': await isConnectedViaMobile(),
      'isEthernet': await isConnectedViaEthernet(),
    };
  }
}
