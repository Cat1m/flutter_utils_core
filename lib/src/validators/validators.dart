import 'phone_validator.dart';
import 'email_validator.dart';

/// Unified validation class for common form validations
class Validators {
  // ============================================================================
  // FORM VALIDATORS (Return error message or null)
  // ============================================================================

  /// Validate required field
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Trường này'} là bắt buộc';
    }
    return null;
  }

  /// Validate email
  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;

    if (!EmailValidator.isValid(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  /// Validate Vietnamese phone number
  static String? phone(String? value) {
    if (value == null || value.isEmpty) return null;

    if (!PhoneValidator.isValidVietnamese(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  // /// Validate Vietnamese ID card (CCCD/CMND)
  // static String? idCard(String? value) {
  //   if (value == null || value.isEmpty) return null;

  //   if (!IdCardValidator.isValidVietnamese(value)) {
  //     return 'CCCD/CMND không hợp lệ';
  //   }
  //   return null;
  // }

  /// Validate password
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return null;

    if (value.length < minLength) {
      return 'Mật khẩu phải có ít nhất $minLength ký tự';
    }
    return null;
  }

  /// Validate confirm password
  static String? confirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) return null;

    if (value != originalPassword) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

  /// Validate minimum length
  static String? minLength(String? value, int minLength, [String? fieldName]) {
    if (value == null || value.isEmpty) return null;

    if (value.length < minLength) {
      return '${fieldName ?? 'Trường này'} phải có ít nhất $minLength ký tự';
    }
    return null;
  }

  /// Validate maximum length
  static String? maxLength(String? value, int maxLength, [String? fieldName]) {
    if (value == null || value.isEmpty) return null;

    if (value.length > maxLength) {
      return '${fieldName ?? 'Trường này'} không được vượt quá $maxLength ký tự';
    }
    return null;
  }

  /// Validate numeric value
  static String? numeric(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) return null;

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'Trường này'} phải là số';
    }
    return null;
  }

  /// Validate integer value
  static String? integer(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) return null;

    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'Trường này'} phải là số nguyên';
    }
    return null;
  }

  /// Validate minimum numeric value
  static String? min(String? value, double minValue, [String? fieldName]) {
    if (value == null || value.isEmpty) return null;

    final numValue = double.tryParse(value);
    if (numValue == null) {
      return '${fieldName ?? 'Trường này'} phải là số';
    }

    if (numValue < minValue) {
      return '${fieldName ?? 'Trường này'} phải lớn hơn hoặc bằng $minValue';
    }
    return null;
  }

  /// Validate maximum numeric value
  static String? max(String? value, double maxValue, [String? fieldName]) {
    if (value == null || value.isEmpty) return null;

    final numValue = double.tryParse(value);
    if (numValue == null) {
      return '${fieldName ?? 'Trường này'} phải là số';
    }

    if (numValue > maxValue) {
      return '${fieldName ?? 'Trường này'} phải nhỏ hơn hoặc bằng $maxValue';
    }
    return null;
  }

  /// Validate URL
  static String? url(String? value) {
    if (value == null || value.isEmpty) return null;

    final urlPattern = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');

    if (!urlPattern.hasMatch(value)) {
      return 'URL không hợp lệ';
    }
    return null;
  }

  /// Validate date string (dd/MM/yyyy)
  static String? date(String? value) {
    if (value == null || value.isEmpty) return null;

    final datePattern = RegExp(r'^\d{2}\/\d{2}\/\d{4}$');
    if (!datePattern.hasMatch(value)) {
      return 'Định dạng ngày không hợp lệ (dd/MM/yyyy)';
    }

    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      if (month < 1 || month > 12) {
        return 'Tháng không hợp lệ (1-12)';
      }

      if (day < 1 || day > 31) {
        return 'Ngày không hợp lệ (1-31)';
      }

      // Check for specific month day limits
      final daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

      // Adjust for leap year
      if (month == 2 &&
          ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0))) {
        daysInMonth[1] = 29;
      }

      if (day > daysInMonth[month - 1]) {
        return 'Ngày không hợp lệ cho tháng $month';
      }
    } catch (e) {
      return 'Định dạng ngày không hợp lệ';
    }

    return null;
  }

  /// Validate time string (HH:mm)
  static String? time(String? value) {
    if (value == null || value.isEmpty) return null;

    final timePattern = RegExp(r'^\d{2}:\d{2}$');
    if (!timePattern.hasMatch(value)) {
      return 'Định dạng giờ không hợp lệ (HH:mm)';
    }

    try {
      final parts = value.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      if (hour < 0 || hour > 23) {
        return 'Giờ không hợp lệ (0-23)';
      }

      if (minute < 0 || minute > 59) {
        return 'Phút không hợp lệ (0-59)';
      }
    } catch (e) {
      return 'Định dạng giờ không hợp lệ';
    }

    return null;
  }

  // ============================================================================
  // COMPOSITE VALIDATORS
  // ============================================================================

  /// Combine multiple validators
  static String? Function(String?) combine(
      List<String? Function(String?)> validators) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }

  /// Create required validator with custom message
  static String? Function(String?) requiredWithMessage(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }
      return null;
    };
  }

  /// Create pattern validator
  static String? Function(String?) pattern(RegExp pattern, String message) {
    return (value) {
      if (value == null || value.isEmpty) return null;

      if (!pattern.hasMatch(value)) {
        return message;
      }
      return null;
    };
  }
}
