import 'package:intl/intl.dart';
import '../constants/vietnamese_constants.dart';

/// DateTime extensions for Vietnamese formatting and utilities
extension DateTimeExtensions on DateTime {
  // ============================================================================
  // VIETNAMESE DATE FORMATTING
  // ============================================================================

  /// Format as Vietnamese date string
  /// DateTime(2024, 3, 12) → "12/03/2024"
  String toVietnameseString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  /// Format as Vietnamese date with time
  /// DateTime(2024, 3, 12, 14, 30) → "12/03/2024 14:30"
  String toVietnameseDateTimeString() {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }

  /// Format as full Vietnamese date
  /// DateTime(2024, 3, 12) → "Thứ ba, 12 tháng 3 năm 2024"
  String toFullVietnameseString() {
    final dayOfWeek = VietnameseConstants.daysOfWeek[weekday - 1];
    final month = VietnameseConstants.months[this.month - 1];
    return '$dayOfWeek, $day $month năm $year';
  }

  /// Format as Vietnamese time
  /// DateTime(2024, 3, 12, 14, 30) → "14:30"
  String toVietnameseTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  /// Format as Vietnamese time with seconds
  /// DateTime(2024, 3, 12, 14, 30, 45) → "14:30:45"
  String toVietnameseTimeWithSecondsString() {
    return DateFormat('HH:mm:ss').format(this);
  }

  /// Format as compact Vietnamese date
  /// DateTime(2024, 3, 12) → "12/3"
  String toCompactVietnameseString() {
    return DateFormat('d/M').format(this);
  }

  /// Format as month and year in Vietnamese
  /// DateTime(2024, 3, 12) → "Tháng 3 năm 2024"
  String toVietnameseMonthYear() {
    final month = VietnameseConstants.months[this.month - 1];
    return '$month năm $year';
  }

  // ============================================================================
  // RELATIVE TIME (Vietnamese)
  // ============================================================================

  /// Get relative time in Vietnamese
  /// Examples: "vừa xong", "2 phút trước", "3 giờ trước", "hôm qua"
  String toVietnameseRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.isNegative) {
      // Future dates
      final futureDiff = difference.abs();
      if (futureDiff.inMinutes < 1) return 'ngay bây giờ';
      if (futureDiff.inMinutes < 60) return 'sau ${futureDiff.inMinutes} phút';
      if (futureDiff.inHours < 24) return 'sau ${futureDiff.inHours} giờ';
      if (futureDiff.inDays < 7) return 'sau ${futureDiff.inDays} ngày';
      return toVietnameseString();
    }

    // Past dates
    if (difference.inSeconds < 30) return 'vừa xong';
    if (difference.inMinutes < 1) return '${difference.inSeconds} giây trước';
    if (difference.inMinutes < 60) return '${difference.inMinutes} phút trước';
    if (difference.inHours < 24) return '${difference.inHours} giờ trước';

    // Check if yesterday
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    if (year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day) {
      return 'hôm qua';
    }

    // Check if this week
    if (difference.inDays < 7) return '${difference.inDays} ngày trước';

    // Older dates
    if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} tuần trước';
    }
    if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} tháng trước';
    }

    return '${(difference.inDays / 365).floor()} năm trước';
  }

  // ============================================================================
  // UTILITY CHECKS
  // ============================================================================

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Check if date is this week
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Check if date is this month
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// Check if date is this year
  bool get isThisYear {
    final now = DateTime.now();
    return year == now.year;
  }

  /// Check if date is weekend (Saturday or Sunday)
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Check if date is weekday (Monday to Friday)
  bool get isWeekday => !isWeekend;

  // ============================================================================
  // DATE MANIPULATIONS
  // ============================================================================

  /// Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day (23:59:59.999)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Get start of week (Monday 00:00:00)
  DateTime get startOfWeek {
    final daysFromMonday = weekday - 1;
    return startOfDay.subtract(Duration(days: daysFromMonday));
  }

  /// Get end of week (Sunday 23:59:59.999)
  DateTime get endOfWeek {
    final daysToSunday = 7 - weekday;
    return endOfDay.add(Duration(days: daysToSunday));
  }

  /// Get start of month (1st day 00:00:00)
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of month (last day 23:59:59.999)
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  /// Get start of year (Jan 1st 00:00:00)
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// Get end of year (Dec 31st 23:59:59.999)
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  /// Add business days (skip weekends)
  DateTime addBusinessDays(int days) {
    DateTime result = this;
    int addedDays = 0;

    while (addedDays < days) {
      result = result.add(const Duration(days: 1));
      if (result.isWeekday) {
        addedDays++;
      }
    }

    return result;
  }

  /// Get age in years
  int get age {
    final now = DateTime.now();
    int age = now.year - year;

    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }

    return age;
  }

  /// Get Vietnamese zodiac sign
  String get vietnameseZodiac {
    final zodiacYear = year % 12;
    const signs = [
      'Tý',
      'Sửu',
      'Dần',
      'Mão',
      'Thìn',
      'Tỵ',
      'Ngọ',
      'Mùi',
      'Thân',
      'Dậu',
      'Tuất',
      'Hợi'
    ];
    return signs[zodiacYear];
  }

  /// Check if leap year
  bool get isLeapYear {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// Get quarter of year (1-4)
  int get quarter => ((month - 1) ~/ 3) + 1;

  /// Format for API (ISO string)
  String toApiString() => toIso8601String();

  /// Create from Vietnamese date string "dd/MM/yyyy"
  static DateTime? fromVietnameseString(String dateString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Create from Vietnamese datetime string "dd/MM/yyyy HH:mm"
  static DateTime? fromVietnameseDateTimeString(String dateTimeString) {
    try {
      return DateFormat('dd/MM/yyyy HH:mm').parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }
}
