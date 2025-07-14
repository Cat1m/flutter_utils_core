import 'dart:async';

/// Mixin for handling loading states
mixin LoadingMixin {
  bool _isLoading = false;
  final Map<String, bool> _loadingStates = {};

  /// Check if currently loading
  bool get isLoading => _isLoading;

  /// Check if specific operation is loading
  bool isLoadingOperation(String operation) =>
      _loadingStates[operation] ?? false;

  /// Get all loading operations
  Map<String, bool> get loadingStates => Map.unmodifiable(_loadingStates);

  /// Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyLoadingChanged();
  }

  /// Set loading state for specific operation
  void setOperationLoading(String operation, bool loading) {
    if (loading) {
      _loadingStates[operation] = true;
    } else {
      _loadingStates.remove(operation);
    }
    notifyLoadingChanged();
  }

  /// Execute operation with loading state
  Future<T> executeWithLoading<T>(Future<T> Function() operation) async {
    setLoading(true);
    try {
      return await operation();
    } finally {
      setLoading(false);
    }
  }

  /// Execute operation with named loading state
  Future<T> executeOperationWithLoading<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    setOperationLoading(operationName, true);
    try {
      return await operation();
    } finally {
      setOperationLoading(operationName, false);
    }
  }

  /// Clear all loading states
  void clearAllLoading() {
    _isLoading = false;
    _loadingStates.clear();
    notifyLoadingChanged();
  }

  /// Check if any operation is loading
  bool get hasAnyLoading => _isLoading || _loadingStates.isNotEmpty;

  /// Get current loading operations
  List<String> get currentLoadingOperations => _loadingStates.keys.toList();

  /// Override this method to handle loading state changes
  void notifyLoadingChanged() {
    // Override in implementing class to notify UI
  }

  /// Dispose loading states
  void disposeLoading() {
    clearAllLoading();
  }
}

/// Extended loading mixin with progress tracking
mixin ProgressLoadingMixin on LoadingMixin {
  final Map<String, double> _progressStates = {};

  /// Get progress for operation (0.0 to 1.0)
  double getProgress(String operation) => _progressStates[operation] ?? 0.0;

  /// Set progress for operation
  void setProgress(String operation, double progress) {
    _progressStates[operation] = progress.clamp(0.0, 1.0);
    notifyProgressChanged(operation, progress);
  }

  /// Execute operation with progress tracking
  Future<T> executeWithProgress<T>(
    String operationName,
    Future<T> Function(void Function(double) updateProgress) operation,
  ) async {
    setOperationLoading(operationName, true);
    setProgress(operationName, 0.0);

    try {
      return await operation((progress) {
        setProgress(operationName, progress);
      });
    } finally {
      setProgress(operationName, 1.0);
      setOperationLoading(operationName, false);
      _progressStates.remove(operationName);
    }
  }

  /// Get all progress states
  Map<String, double> get progressStates => Map.unmodifiable(_progressStates);

  /// Clear progress for operation
  void clearProgress(String operation) {
    _progressStates.remove(operation);
    notifyProgressChanged(operation, 0.0);
  }

  /// Clear all progress states
  void clearAllProgress() {
    _progressStates.clear();
  }

  /// Override this method to handle progress changes
  void notifyProgressChanged(String operation, double progress) {
    // Override in implementing class to notify UI
  }

  @override
  void disposeLoading() {
    clearAllProgress();
    super.disposeLoading();
  }
}

/// Loading mixin with timeout support
mixin TimeoutLoadingMixin on LoadingMixin {
  final Map<String, Timer> _timeoutTimers = {};

  /// Execute operation with timeout
  Future<T> executeWithTimeout<T>(
    Future<T> Function() operation, {
    Duration timeout = const Duration(seconds: 30),
    String? operationName,
  }) async {
    final name = operationName ?? 'timeout_operation';

    if (operationName != null) {
      setOperationLoading(operationName, true);
    } else {
      setLoading(true);
    }

    // Set timeout timer
    final timer = Timer(timeout, () {
      if (operationName != null) {
        setOperationLoading(operationName, false);
      } else {
        setLoading(false);
      }
      notifyTimeout(name);
    });

    _timeoutTimers[name] = timer;

    try {
      return await operation().timeout(timeout);
    } on TimeoutException {
      notifyTimeout(name);
      rethrow;
    } finally {
      timer.cancel();
      _timeoutTimers.remove(name);

      if (operationName != null) {
        setOperationLoading(operationName, false);
      } else {
        setLoading(false);
      }
    }
  }

  /// Cancel timeout for operation
  void cancelTimeout(String operationName) {
    _timeoutTimers[operationName]?.cancel();
    _timeoutTimers.remove(operationName);
  }

  /// Cancel all timeouts
  void cancelAllTimeouts() {
    for (final timer in _timeoutTimers.values) {
      timer.cancel();
    }
    _timeoutTimers.clear();
  }

  /// Override this method to handle timeouts
  void notifyTimeout(String operationName) {
    // Override in implementing class to handle timeout
  }

  @override
  void disposeLoading() {
    cancelAllTimeouts();
    super.disposeLoading();
  }
}
