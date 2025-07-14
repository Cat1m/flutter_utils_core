import 'package:intl/intl.dart';

/// Vietnamese currency formatter utilities
class CurrencyFormatter {
  CurrencyFormatter._();

  static const String _vndSymbol = '₫';
  static const String _vndCode = 'VND';

  /// Format number as Vietnamese Dong (VND)
  static String toVND(
    num amount, {
    bool showSymbol = true,
    bool showCode = false,
    int decimalPlaces = 0,
    bool compact = false,
  }) {
    if (compact) {
      return toCompactVND(amount, showSymbol: showSymbol);
    }

    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: showSymbol ? _vndSymbol : '',
      decimalDigits: decimalPlaces,
    );

    String formatted = formatter.format(amount);

    if (showCode && !showSymbol) {
      formatted = '$formatted $_vndCode';
    } else if (showCode && showSymbol) {
      formatted = formatted.replaceAll(_vndSymbol, '$_vndCode $_vndSymbol');
    }

    return formatted;
  }

  /// Format number as compact VND (1.5M ₫)
  static String toCompactVND(num amount, {bool showSymbol = true}) {
    String suffix = '';
    double value = amount.toDouble();

    if (value >= 1000000000) {
      value = value / 1000000000;
      suffix = 'B'; // Billion
    } else if (value >= 1000000) {
      value = value / 1000000;
      suffix = 'M'; // Million
    } else if (value >= 1000) {
      value = value / 1000;
      suffix = 'K'; // Thousand
    }

    // Format with appropriate decimal places
    String formatted;
    if (value == value.roundToDouble()) {
      formatted = value.toInt().toString();
    } else {
      formatted = value.toStringAsFixed(1);
    }

    final result = '$formatted$suffix';
    return showSymbol ? '$result $_vndSymbol' : result;
  }

  /// Parse VND string back to number
  static double? parseVND(String vndString) {
    try {
      // Remove currency symbols and formatting
      String cleaned = vndString
          .replaceAll(_vndSymbol, '')
          .replaceAll(_vndCode, '')
          .replaceAll(',', '')
          .replaceAll('.', '')
          .replaceAll(' ', '')
          .trim();

      // Handle compact notation
      if (cleaned.toUpperCase().endsWith('K')) {
        cleaned = cleaned.substring(0, cleaned.length - 1);
        return double.parse(cleaned) * 1000;
      } else if (cleaned.toUpperCase().endsWith('M')) {
        cleaned = cleaned.substring(0, cleaned.length - 1);
        return double.parse(cleaned) * 1000000;
      } else if (cleaned.toUpperCase().endsWith('B')) {
        cleaned = cleaned.substring(0, cleaned.length - 1);
        return double.parse(cleaned) * 1000000000;
      }

      return double.parse(cleaned);
    } catch (e) {
      return null;
    }
  }

  /// Format as price range
  static String toPriceRange(num minPrice, num maxPrice,
      {bool compact = false}) {
    final min = compact ? toCompactVND(minPrice) : toVND(minPrice);
    final max = compact ? toCompactVND(maxPrice) : toVND(maxPrice);
    return '$min - $max';
  }

  /// Format with Vietnamese text
  static String toVietnameseText(num amount) {
    final vnd = toVND(amount);
    return '$vnd (${_numberToVietnameseWords(amount.toInt())} đồng)';
  }

  /// Convert number to Vietnamese words
  static String _numberToVietnameseWords(int number) {
    if (number == 0) return 'không';

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
        String chunkText = _convertChunkToVietnamese(chunk, ones, tens);
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

  static String _convertChunkToVietnamese(
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

  /// Format as bank account balance style
  static String toBankBalance(num amount) {
    return '${toVND(amount)} VND';
  }

  /// Check if amount is valid for VND
  static bool isValidVNDAmount(num amount) {
    // VND doesn't use decimal places in practice
    return amount >= 0 && amount % 1 == 0;
  }

  /// Round to nearest valid VND amount
  static int roundToVND(num amount) {
    return amount.round();
  }

  /// Calculate percentage and format as VND
  static String calculatePercentage(num amount, double percentage) {
    final result = amount * (percentage / 100);
    return toVND(result);
  }

  /// Format as discount
  static String formatDiscount(num originalPrice, num discountedPrice) {
    final discount = originalPrice - discountedPrice;
    final percentage = (discount / originalPrice * 100).round();
    return 'Giảm ${toVND(discount)} ($percentage%)';
  }

  /// Format for e-commerce display
  static String formatEcommerce(num price, {num? originalPrice}) {
    if (originalPrice != null && originalPrice > price) {
      return '${toVND(price)} (Giá gốc: ${toVND(originalPrice)})';
    }
    return toVND(price);
  }
}
