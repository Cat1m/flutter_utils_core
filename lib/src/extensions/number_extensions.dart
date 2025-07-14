import 'package:intl/intl.dart';

/// Number extensions for formatting and utilities
extension IntExtensions on int {
  // ============================================================================
  // VIETNAMESE CURRENCY FORMATTING
  // ============================================================================

  /// Format as Vietnamese currency
  /// 1000000 → "1.000.000 ₫"
  String toVND({bool showSymbol = true}) {
    final formatter = NumberFormat('#,##0', 'vi_VN');
    final formatted = formatter.format(this).replaceAll(',', '.');
    return showSymbol ? '$formatted ₫' : formatted;
  }

  /// Format as compact Vietnamese currency
  /// 1500000 → "1,5M ₫"
  String toCompactVND({bool showSymbol = true}) {
    if (this < 1000) {
      return showSymbol ? '$this ₫' : toString();
    } else if (this < 1000000) {
      final thousands = this / 1000;
      final formatted = thousands == thousands.toInt()
          ? '${thousands.toInt()}K'
          : '${thousands.toStringAsFixed(1).replaceAll('.', ',')}K';
      return showSymbol ? '$formatted ₫' : formatted;
    } else if (this < 1000000000) {
      final millions = this / 1000000;
      final formatted = millions == millions.toInt()
          ? '${millions.toInt()}M'
          : '${millions.toStringAsFixed(1).replaceAll('.', ',')}M';
      return showSymbol ? '$formatted ₫' : formatted;
    } else {
      final billions = this / 1000000000;
      final formatted = billions == billions.toInt()
          ? '${billions.toInt()}B'
          : '${billions.toStringAsFixed(1).replaceAll('.', ',')}B';
      return showSymbol ? '$formatted ₫' : formatted;
    }
  }

  // ============================================================================
  // GENERAL FORMATTING
  // ============================================================================

  /// Format with thousand separators (Vietnamese style with dots)
  /// 1000000 → "1.000.000"
  String toFormattedString() {
    return toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)}.',
    );
  }

  /// Convert to ordinal string (Vietnamese)
  /// 1 → "thứ nhất", 2 → "thứ hai"
  String toVietnameseOrdinal() {
    switch (this) {
      case 1:
        return 'thứ nhất';
      case 2:
        return 'thứ hai';
      case 3:
        return 'thứ ba';
      case 4:
        return 'thứ tư';
      case 5:
        return 'thứ năm';
      case 6:
        return 'thứ sáu';
      case 7:
        return 'thứ bảy';
      case 8:
        return 'thứ tám';
      case 9:
        return 'thứ chín';
      case 10:
        return 'thứ mười';
      default:
        return 'thứ $this';
    }
  }

  // ============================================================================
  // UTILITY
  // ============================================================================

  /// Check if number is in range (inclusive)
  bool isInRange(int min, int max) => this >= min && this <= max;

  /// Clamp number to range
  int clampToRange(int min, int max) =>
      this < min ? min : (this > max ? max : this);

  /// Convert bytes to human readable format
  /// 1024 → "1 KB"
  String toBytesString() {
    if (this < 1024) return '$this B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Convert milliseconds to duration string
  /// 90000 → "1 phút 30 giây"
  String toVietnameseDuration() {
    final duration = Duration(milliseconds: this);
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    final parts = <String>[];
    if (days > 0) parts.add('$days ngày');
    if (hours > 0) parts.add('$hours giờ');
    if (minutes > 0) parts.add('$minutes phút');
    if (seconds > 0) parts.add('$seconds giây');

    return parts.isEmpty ? '0 giây' : parts.join(' ');
  }
}

/// Double extensions for formatting and utilities
extension DoubleExtensions on double {
  // ============================================================================
  // VIETNAMESE CURRENCY FORMATTING
  // ============================================================================

  /// Format as Vietnamese currency
  /// 1000000.5 → "1.000.000,5 ₫"
  String toVND({bool showSymbol = true, int decimalPlaces = 0}) {
    final formatter = NumberFormat('#,##0.${'0' * decimalPlaces}', 'vi_VN');
    final formatted = formatter.format(this).replaceAll(',', '.');
    return showSymbol ? '$formatted ₫' : formatted;
  }

  /// Format as percentage (Vietnamese style)
  /// 0.15 → "15%"
  String toVietnamesePercentage({int decimalPlaces = 1}) {
    final percentage = this * 100;
    return '${percentage.toStringAsFixed(decimalPlaces).replaceAll('.', ',')}%';
  }

  // ============================================================================
  // UTILITY
  // ============================================================================

  /// Round to specific decimal places
  double roundToPlaces(int places) {
    final factor = 1.0 * (10 * places);
    return (this * factor).round() / factor;
  }

  /// Check if number is in range (inclusive)
  bool isInRange(double min, double max) => this >= min && this <= max;

  /// Convert to compact string
  /// 1500.0 → "1.5K"
  String toCompactString() {
    if (this < 1000) {
      return toStringAsFixed(0);
    } else if (this < 1000000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    } else if (this < 1000000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else {
      return '${(this / 1000000000).toStringAsFixed(1)}B';
    }
  }
}
