import 'package:intl/intl.dart';

/// Vietnamese date and time formatter utilities
class DateFormatter {
  DateFormatter._();

  // Vietnamese day names
  static const List<String> _vietnameseDayNames = [
    'Chủ nhật',
    'Thứ hai',
    'Thứ ba',
    'Thứ tư',
    'Thứ năm',
    'Thứ sáu',
    'Thứ bảy',
  ];

  // Vietnamese month names
  static const List<String> _vietnameseMonthNames = [
    '',
    'tháng 1',
    'tháng 2',
    'tháng 3',
    'tháng 4',
    'tháng 5',
    'tháng 6',
    'tháng 7',
    'tháng 8',
    'tháng 9',
    'tháng 10',
    'tháng 11',
    'tháng 12',
  ];

  // Short Vietnamese month names
  static const List<String> _vietnameseShortMonthNames = [
    '',
    'Th1',
    'Th2',
    'Th3',
    'Th4',
    'Th5',
    'Th6',
    'Th7',
    'Th8',
    'Th9',
    'Th10',
    'Th11',
    'Th12',
  ];

  /// Format date in Vietnamese style (dd/MM/yyyy)
  static String toVietnameseDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format date in short Vietnamese style (dd/MM/yy)
  static String toShortVietnameseDate(DateTime date) {
    return DateFormat('dd/MM/yy').format(date);
  }

  /// Format date in full Vietnamese style
  /// Example: "Thứ hai, ngày 15 tháng 3 năm 2024"
  static String toFullVietnameseDate(DateTime date) {
    final dayName = _vietnameseDayNames[date.weekday % 7];
    final monthName = _vietnameseMonthNames[date.month];
    return '$dayName, ngày ${date.day} $monthName năm ${date.year}';
  }

  /// Format date without day name
  /// Example: "15 tháng 3 năm 2024"
  static String toVietnameseDateWithoutDay(DateTime date) {
    final monthName = _vietnameseMonthNames[date.month];
    return 'ngày ${date.day} $monthName năm ${date.year}';
  }

  /// Format time in Vietnamese style (HH:mm)
  static String toVietnameseTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  /// Format time with seconds (HH:mm:ss)
  static String toVietnameseTimeWithSeconds(DateTime date) {
    return DateFormat('HH:mm:ss').format(date);
  }

  /// Format datetime in Vietnamese style
  /// Example: "15/03/2024 14:30"
  static String toVietnameseDateTime(DateTime date) {
    return '${toVietnameseDate(date)} ${toVietnameseTime(date)}';
  }

  /// Format datetime with seconds
  /// Example: "15/03/2024 14:30:45"
  static String toVietnameseDateTimeWithSeconds(DateTime date) {
    return '${toVietnameseDate(date)} ${toVietnameseTimeWithSeconds(date)}';
  }

  /// Format relative time in Vietnamese
  static String toRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'vừa xong';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks tuần trước';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months tháng trước';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years năm trước';
    }
  }

  /// Format birthday in Vietnamese
  static String toBirthday(DateTime birthDate) {
    final age = DateTime.now().year - birthDate.year;
    return '${toVietnameseDate(birthDate)} ($age tuổi)';
  }

  /// Format month and year
  /// Example: "Tháng 3/2024"
  static String toMonthYear(DateTime date) {
    return 'Tháng ${date.month}/${date.year}';
  }

  /// Format quarter and year
  /// Example: "Quý 1/2024"
  static String toQuarterYear(DateTime date) {
    final quarter = ((date.month - 1) ~/ 3) + 1;
    return 'Quý $quarter/${date.year}';
  }

  /// Format academic year (starts from September)
  /// Example: "Năm học 2023-2024"
  static String toAcademicYear(DateTime date) {
    if (date.month >= 9) {
      return 'Năm học ${date.year}-${date.year + 1}';
    } else {
      return 'Năm học ${date.year - 1}-${date.year}';
    }
  }

  /// Format time period
  static String formatTimePeriod(DateTime start, DateTime end) {
    if (start.year == end.year &&
        start.month == end.month &&
        start.day == end.day) {
      return '${toVietnameseDate(start)}, ${toVietnameseTime(start)} - ${toVietnameseTime(end)}';
    } else {
      return '${toVietnameseDateTime(start)} - ${toVietnameseDateTime(end)}';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Format smart date (today, yesterday, or date)
  static String toSmartDate(DateTime date) {
    if (isToday(date)) {
      return 'Hôm nay, ${toVietnameseTime(date)}';
    } else if (isYesterday(date)) {
      return 'Hôm qua, ${toVietnameseTime(date)}';
    } else if (isTomorrow(date)) {
      return 'Ngày mai, ${toVietnameseTime(date)}';
    } else {
      return toVietnameseDateTime(date);
    }
  }

  /// Parse Vietnamese date string
  static DateTime? parseVietnameseDate(String dateString) {
    try {
      // Try different formats
      final formats = [
        'dd/MM/yyyy',
        'dd/MM/yy',
        'dd-MM-yyyy',
        'dd-MM-yy',
        'yyyy-MM-dd',
      ];

      for (final format in formats) {
        try {
          return DateFormat(format).parse(dateString);
        } catch (e) {
          continue;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get Vietnamese day name
  static String getVietnameseDayName(DateTime date) {
    return _vietnameseDayNames[date.weekday % 7];
  }

  /// Get Vietnamese month name
  static String getVietnameseMonthName(DateTime date) {
    return _vietnameseMonthNames[date.month];
  }

  /// Get short Vietnamese month name
  static String getShortVietnameseMonthName(DateTime date) {
    return _vietnameseShortMonthNames[date.month];
  }

  /// Format age from birth date
  static String formatAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return '$age tuổi';
  }

  /// Format work hours
  static String formatWorkHours(DateTime start, DateTime end) {
    return '${toVietnameseTime(start)} - ${toVietnameseTime(end)}';
  }

  /// Check if date is weekend
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  /// Check if date is working day
  static bool isWorkingDay(DateTime date) {
    return !isWeekend(date);
  }

  /// Format duration in Vietnamese
  static String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} ngày ${duration.inHours % 24} giờ';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} giờ ${duration.inMinutes % 60} phút';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} phút';
    } else {
      return '${duration.inSeconds} giây';
    }
  }
}
