import 'dart:math';

import 'package:intl/intl.dart';

/// Number formatter utilities for Vietnamese locale
class NumberFormatter {
  NumberFormatter._();

  /// Format number with Vietnamese locale
  static String format(num number, {int? decimalPlaces}) {
    final formatter = NumberFormat.decimalPattern('vi_VN');
    if (decimalPlaces != null) {
      formatter.minimumFractionDigits = decimalPlaces;
      formatter.maximumFractionDigits = decimalPlaces;
    }
    return formatter.format(number);
  }

  /// Format as percentage
  static String toPercentage(num value, {int decimalPlaces = 1}) {
    final formatter = NumberFormat.percentPattern('vi_VN');
    formatter.minimumFractionDigits = decimalPlaces;
    formatter.maximumFractionDigits = decimalPlaces;
    return formatter.format(value / 100);
  }

  /// Format as compact number (1.2K, 1.5M, etc.)
  static String toCompact(num number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
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

  /// Format with ordinal suffix (1st, 2nd, 3rd, etc.) in Vietnamese
  static String toOrdinal(int number) {
    if (number == 1) return 'thứ nhất';
    if (number == 2) return 'thứ hai';
    if (number == 3) return 'thứ ba';
    if (number == 4) return 'thứ tư';
    if (number == 5) return 'thứ năm';
    return 'thứ $number';
  }

  /// Convert number to Vietnamese words
  static String toVietnameseWords(int number) {
    if (number == 0) return 'không';
    if (number < 0) return 'âm ${toVietnameseWords(-number)}';

    final ones = [
      '',
      'một',
      'hai',
      'ba',
      'bốn',
      'năm',
      'sáu',
      'bảy',
      'tám',
      'chín'
    ];

    final tens = [
      '',
      '',
      'hai mươi',
      'ba mươi',
      'bốn mươi',
      'năm mươi',
      'sáu mươi',
      'bảy mươi',
      'tám mươi',
      'chín mươi'
    ];

    final scales = ['', 'nghìn', 'triệu', 'tỷ'];

    String result = '';
    int scaleIndex = 0;

    while (number > 0) {
      int chunk = number % 1000;
      if (chunk != 0) {
        String chunkText = _convertChunkToWords(chunk, ones, tens);
        if (scaleIndex > 0) {
          chunkText += ' ${scales[scaleIndex]}';
        }
        result = chunkText + (result.isEmpty ? '' : ' $result');
      }
      number ~/= 1000;
      scaleIndex++;
    }

    return result;
  }

  static String _convertChunkToWords(
      int chunk, List<String> ones, List<String> tens) {
    String result = '';

    int hundreds = chunk ~/ 100;
    int remainder = chunk % 100;
    int tensDigit = remainder ~/ 10;
    int onesDigit = remainder % 10;

    if (hundreds > 0) {
      result = '${ones[hundreds]} trăm';
    }

    if (tensDigit > 1) {
      if (result.isNotEmpty) result += ' ';
      result += tens[tensDigit];
      if (onesDigit > 0) {
        result += ' ${ones[onesDigit]}';
      }
    } else if (tensDigit == 1) {
      if (result.isNotEmpty) result += ' ';
      result += 'mười';
      if (onesDigit > 0) {
        result += ' ${ones[onesDigit]}';
      }
    } else if (onesDigit > 0) {
      if (result.isNotEmpty) result += ' lẻ ';
      result += ones[onesDigit];
    }

    return result;
  }

  /// Format number with unit
  static String formatWithUnit(num number, String unit) {
    return '${format(number)} $unit';
  }

  /// Format score (0-10 scale)
  static String formatScore(double score, {int decimalPlaces = 1}) {
    return score.toStringAsFixed(decimalPlaces);
  }

  /// Format rating (with stars)
  static String formatRating(double rating, {int maxStars = 5}) {
    final stars = '★' * rating.floor() + '☆' * (maxStars - rating.floor());
    return '$stars (${rating.toStringAsFixed(1)})';
  }

  /// Format temperature
  static String formatTemperature(num temperature, {String unit = '°C'}) {
    return '${temperature.toStringAsFixed(1)}$unit';
  }

  /// Format distance
  static String formatDistance(num meters) {
    if (meters >= 1000) {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    } else {
      return '${meters.toInt()} m';
    }
  }

  /// Format speed
  static String formatSpeed(num kmh) {
    return '${kmh.toStringAsFixed(1)} km/h';
  }

  /// Format weight
  static String formatWeight(num grams) {
    if (grams >= 1000) {
      return '${(grams / 1000).toStringAsFixed(1)} kg';
    } else {
      return '${grams.toInt()} g';
    }
  }

  /// Parse Vietnamese number string
  static double? parseVietnameseNumber(String numberString) {
    try {
      // Remove Vietnamese formatting
      String cleaned = numberString
          .replaceAll('.', '') // Remove thousand separators
          .replaceAll(',', '.') // Replace decimal separator
          .trim();

      return double.parse(cleaned);
    } catch (e) {
      return null;
    }
  }

  /// Format with leading zeros
  static String withLeadingZeros(int number, int width) {
    return number.toString().padLeft(width, '0');
  }

  /// Format phone number
  static String formatPhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length == 10) {
      return '${digits.substring(0, 4)} ${digits.substring(4, 7)} ${digits.substring(7)}';
    }
    return phone;
  }

  /// Calculate and format percentage change
  static String formatPercentageChange(num oldValue, num newValue) {
    if (oldValue == 0) return '0%';

    final change = ((newValue - oldValue) / oldValue) * 100;
    final sign = change >= 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(1)}%';
  }

  /// Format large numbers with Vietnamese scale
  static String formatLargeNumber(num number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)} tỷ';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)} triệu';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)} nghìn';
    } else {
      return number.toString();
    }
  }

  /// Check if number is valid
  static bool isValidNumber(String input) {
    return double.tryParse(input.replaceAll(',', '.')) != null;
  }

  /// Round to specific decimal places
  static double roundToDecimal(double number, int decimalPlaces) {
    final factor = pow(10, decimalPlaces);
    return (number * factor).round() / factor;
  }
}
