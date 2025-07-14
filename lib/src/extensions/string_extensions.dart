import '../constants/vietnamese_constants.dart';

/// String extensions for Vietnamese text processing and common operations
extension StringExtensions on String {
  // ============================================================================
  // VIETNAMESE TEXT PROCESSING
  // ============================================================================

  /// Remove Vietnamese tones from string
  /// "Đây là tiếng Việt" → "Day la tieng Viet"
  String removeVietnameseTones() {
    String result = this;

    for (int i = 0; i < VietnameseConstants.vietnameseChars.length; i++) {
      result = result.replaceAll(VietnameseConstants.vietnameseChars[i],
          VietnameseConstants.normalChars[i]);
    }

    return result;
  }

  /// Convert to search-friendly format (lowercase + no tones)
  /// "Nguyễn Văn A" → "nguyen van a"
  String toSearchFormat() {
    return removeVietnameseTones().toLowerCase().trim();
  }

  /// Capitalize first letter of each word (Vietnamese names)
  /// "nguyễn văn a" → "Nguyễn Văn A"
  String toProperCase() {
    if (isEmpty) return this;

    return split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  // ============================================================================
  // VALIDATION CHECKS
  // ============================================================================

  /// Check if string is valid email
  bool get isValidEmail {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(this);
  }

  /// Check if string is valid Vietnamese phone number
  bool get isValidVietnamesePhone {
    // Remove all non-digits
    final digits = replaceAll(RegExp(r'[^\d]'), '');

    // Check length and prefixes
    if (digits.length == 10 && digits.startsWith('0')) {
      final prefix = digits.substring(0, 3);
      return VietnameseConstants.phoneCarrierPrefixes.contains(prefix);
    }

    if (digits.length == 11 && digits.startsWith('84')) {
      final prefix = '0${digits.substring(2, 4)}';
      return VietnameseConstants.phoneCarrierPrefixes.contains(prefix);
    }

    return false;
  }

  /// Check if string is valid Vietnamese ID card (CCCD/CMND)
  bool get isValidVietnameseId {
    final digits = replaceAll(RegExp(r'[^\d]'), '');
    return digits.length == 9 || digits.length == 12;
  }

  /// Check if string contains only Vietnamese characters
  bool get isVietnameseText {
    return RegExp(
            r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂẾưăạảấầẩẫậắằẳẵặẹẻẽềềểếỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵýỷỹ\s]+$')
        .hasMatch(this);
  }

  // ============================================================================
  // FORMATTING
  // ============================================================================

  /// Format as Vietnamese phone number
  /// "0912345678" → "091 234 5678"
  String formatVietnamesePhone() {
    final digits = replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length == 10) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    }

    return this;
  }

  /// Format as Vietnamese ID card
  /// "123456789" → "123 456 789"
  /// "123456789012" → "123 456 789 012"
  String formatVietnameseId() {
    final digits = replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length == 9) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    } else if (digits.length == 12) {
      return '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 9)} ${digits.substring(9)}';
    }

    return this;
  }

  /// Format as Vietnamese currency (remove non-digits and add thousand separators)
  /// "1000000" → "1.000.000"
  String formatVietnameseCurrency() {
    final digits = replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return '';

    final number = int.tryParse(digits);
    if (number == null) return this;

    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match.group(1)}.',
        );
  }

  // ============================================================================
  // UTILITY
  // ============================================================================

  /// Check if string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Get initials from full name
  /// "Nguyễn Văn A" → "NVA"
  String get initials {
    if (isEmpty) return '';

    final words = trim().split(' ').where((word) => word.isNotEmpty);
    if (words.isEmpty) return '';

    if (words.length == 1) {
      return words.first[0].toUpperCase();
    }

    return words.map((word) => word[0].toUpperCase()).join('');
  }

  /// Truncate string with ellipsis
  /// "Very long text here".truncate(10) → "Very long..."
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// Convert string to slug (URL-friendly)
  /// "Đây là tiêu đề" → "day-la-tieu-de"
  String toSlug() {
    return removeVietnameseTones()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'[\s_-]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

  /// Mask sensitive information
  /// "0912345678".mask(start: 3, end: 3) → "091*****678"
  String mask({int start = 0, int end = 0, String maskChar = '*'}) {
    if (length <= start + end) return this;

    final startPart = substring(0, start);
    final endPart = substring(length - end);
    final maskLength = length - start - end;
    final masked = maskChar * maskLength;

    return '$startPart$masked$endPart';
  }

  /// Extract numbers from string
  /// "Price: 1,000,000 VND" → "1000000"
  String get numbersOnly => replaceAll(RegExp(r'[^\d]'), '');

  /// Check if string is numeric
  bool get isNumeric => double.tryParse(this) != null;

  /// Parse as Vietnamese number (with dot thousands separator)
  /// "1.000.000" → 1000000
  double? parseVietnameseNumber() {
    final cleaned = replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(cleaned);
  }
}
