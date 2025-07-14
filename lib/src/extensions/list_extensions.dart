/// Extension methods for List class
extension ListExtensions<T> on List<T> {
  /// Check if list is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if list is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Get element at index or null if out of bounds
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Add element if not null
  void addIfNotNull(T? element) {
    if (element != null) {
      add(element);
    }
  }

  /// Add all elements if not null
  void addAllIfNotNull(Iterable<T>? elements) {
    if (elements != null) {
      addAll(elements);
    }
  }

  /// Remove duplicates from list
  List<T> get unique {
    return toSet().toList();
  }

  /// Remove duplicates by key
  List<T> uniqueBy<K>(K Function(T) keySelector) {
    final seen = <K>{};
    return where((element) => seen.add(keySelector(element))).toList();
  }

  /// Chunk list into smaller lists of specified size
  List<List<T>> chunk(int size) {
    if (size <= 0) throw ArgumentError('Size must be positive');
    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      final end = (i + size < length) ? i + size : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }

  /// Split list into two based on predicate
  ({List<T> matching, List<T> notMatching}) partition(
      bool Function(T) predicate) {
    final matching = <T>[];
    final notMatching = <T>[];

    for (final element in this) {
      if (predicate(element)) {
        matching.add(element);
      } else {
        notMatching.add(element);
      }
    }

    return (matching: matching, notMatching: notMatching);
  }

  /// Get random element from list
  T? get random {
    if (isEmpty) return null;
    final random = DateTime.now().millisecondsSinceEpoch % length;
    return this[random];
  }

  /// Shuffle list in place
  void shuffleInPlace() {
    for (int i = length - 1; i > 0; i--) {
      final random = DateTime.now().millisecondsSinceEpoch % (i + 1);
      final temp = this[i];
      this[i] = this[random];
      this[random] = temp;
    }
  }

  /// Get shuffled copy of list
  List<T> get shuffled {
    final copy = List<T>.from(this);
    copy.shuffleInPlace();
    return copy;
  }

  /// Group elements by key
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => <T>[]).add(element);
    }
    return map;
  }

  /// Find duplicates in list
  List<T> get duplicates {
    final seen = <T>{};
    final duplicates = <T>{};

    for (final element in this) {
      if (!seen.add(element)) {
        duplicates.add(element);
      }
    }

    return duplicates.toList();
  }

  /// Check if list contains all elements
  bool containsAll(Iterable<T> elements) {
    return elements.every(contains);
  }

  /// Check if list contains any element
  bool containsAny(Iterable<T> elements) {
    return elements.any(contains);
  }

  /// Replace all occurrences of element
  void replaceAll(T oldElement, T newElement) {
    for (int i = 0; i < length; i++) {
      if (this[i] == oldElement) {
        this[i] = newElement;
      }
    }
  }

  /// Replace element at index if valid
  bool replaceAt(int index, T element) {
    if (index < 0 || index >= length) return false;
    this[index] = element;
    return true;
  }

  /// Safely remove element at index
  T? removeAtSafe(int index) {
    if (index < 0 || index >= length) return null;
    return removeAt(index);
  }

  /// Remove all elements that match predicate
  void removeWhereIndexed(bool Function(T element, int index) predicate) {
    for (int i = length - 1; i >= 0; i--) {
      if (predicate(this[i], i)) {
        removeAt(i);
      }
    }
  }

  /// Map with index
  List<R> mapIndexed<R>(R Function(T element, int index) mapper) {
    final result = <R>[];
    for (int i = 0; i < length; i++) {
      result.add(mapper(this[i], i));
    }
    return result;
  }

  /// For each with index
  void forEachIndexed(void Function(T element, int index) action) {
    for (int i = 0; i < length; i++) {
      action(this[i], i);
    }
  }

  /// Get sublist safely
  List<T> safeSublist(int start, [int? end]) {
    final safeStart = start.clamp(0, length);
    final safeEnd = (end ?? length).clamp(safeStart, length);
    return sublist(safeStart, safeEnd);
  }
}

/// Extension methods for nullable List
extension NullableListExtensions<T> on List<T>? {
  /// Check if list is null or empty
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  /// Check if list is not null and not empty
  bool get isNotNullOrEmpty => this?.isNotEmpty ?? false;

  /// Get length or 0 if null
  int get safeLength => this?.length ?? 0;

  /// Get first element or null
  T? get firstOrNull => this?.firstOrNull;

  /// Get last element or null
  T? get lastOrNull => this?.lastOrNull;
}
