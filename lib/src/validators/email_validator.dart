/// Email validator utility
class EmailValidator {
  EmailValidator._();

  // Common email domains in Vietnam
  static const List<String> _commonVietnameseDomains = [
    'gmail.com',
    'yahoo.com',
    'hotmail.com',
    'outlook.com',
    'viettel.vn',
    'vinaphone.vn',
    'fpt.com.vn',
    'vnpt.vn',
    'mobifone.vn',
    'vnu.edu.vn',
    'hust.edu.vn',
    'uit.edu.vn',
    'hcmus.edu.vn',
    'hcmut.edu.vn',
  ];

  // Disposable email domains (commonly used for spam)
  static const List<String> _disposableEmailDomains = [
    '10minutemail.com',
    'tempmail.org',
    'guerrillamail.com',
    'mailinator.com',
    'throwaway.email',
    'temp-mail.org',
    'getairmail.com',
    'yopmail.com',
  ];

  /// Basic email validation using regex
  static bool isValidFormat(String email) {
    if (email.isEmpty) return false;

    // Basic email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email.trim());
  }

  /// Comprehensive email validation
  static bool isValid(String email) {
    if (!isValidFormat(email)) return false;

    final trimmedEmail = email.trim().toLowerCase();

    // Check for multiple @ symbols
    if (trimmedEmail.split('@').length != 2) return false;

    final parts = trimmedEmail.split('@');
    final localPart = parts[0];
    final domainPart = parts[1];

    // Validate local part
    if (!_isValidLocalPart(localPart)) return false;

    // Validate domain part
    if (!_isValidDomainPart(domainPart)) return false;

    return true;
  }

  /// Check if email domain is commonly used in Vietnam
  static bool isVietnameseDomain(String email) {
    if (!isValidFormat(email)) return false;

    final domain = email.trim().toLowerCase().split('@').last;
    return _commonVietnameseDomains.contains(domain);
  }

  /// Check if email is from a disposable email service
  static bool isDisposableEmail(String email) {
    if (!isValidFormat(email)) return false;

    final domain = email.trim().toLowerCase().split('@').last;
    return _disposableEmailDomains.contains(domain);
  }

  /// Extract domain from email
  static String? getDomain(String email) {
    if (!isValidFormat(email)) return null;

    return email.trim().toLowerCase().split('@').last;
  }

  /// Extract username (local part) from email
  static String? getUsername(String email) {
    if (!isValidFormat(email)) return null;

    return email.trim().toLowerCase().split('@').first;
  }

  /// Check if email is from educational institution
  static bool isEducationalEmail(String email) {
    final domain = getDomain(email);
    if (domain == null) return false;

    return domain.endsWith('.edu') ||
        domain.endsWith('.edu.vn') ||
        domain.endsWith('.ac.vn') ||
        _commonVietnameseDomains
            .where((d) => d.contains('.edu.'))
            .contains(domain);
  }

  /// Check if email is from government domain
  static bool isGovernmentEmail(String email) {
    final domain = getDomain(email);
    if (domain == null) return false;

    return domain.endsWith('.gov') ||
        domain.endsWith('.gov.vn') ||
        domain.endsWith('.vn') &&
            (domain.contains('gov') || domain.contains('ministry'));
  }

  /// Suggest corrections for common typos
  static String? suggestCorrection(String email) {
    if (isValid(email)) return null;

    final trimmedEmail = email.trim().toLowerCase();

    // Common domain typos
    final domainCorrections = {
      'gmial.com': 'gmail.com',
      'gmai.com': 'gmail.com',
      'gmail.co': 'gmail.com',
      'yahooo.com': 'yahoo.com',
      'yaho.com': 'yahoo.com',
      'hotmial.com': 'hotmail.com',
      'hotmai.com': 'hotmail.com',
      'outlok.com': 'outlook.com',
      'outllok.com': 'outlook.com',
    };

    for (final typo in domainCorrections.keys) {
      if (trimmedEmail.endsWith('@$typo')) {
        return trimmedEmail.replaceFirst(
            '@$typo', '@${domainCorrections[typo]}');
      }
    }

    return null;
  }

  /// Validate local part of email
  static bool _isValidLocalPart(String localPart) {
    if (localPart.isEmpty || localPart.length > 64) return false;

    // Cannot start or end with dot
    if (localPart.startsWith('.') || localPart.endsWith('.')) return false;

    // Cannot have consecutive dots
    if (localPart.contains('..')) return false;

    // Valid characters: letters, numbers, and . _ + - %
    final validChars = RegExp(r'^[a-zA-Z0-9._%+-]+$');
    return validChars.hasMatch(localPart);
  }

  /// Validate domain part of email
  static bool _isValidDomainPart(String domainPart) {
    if (domainPart.isEmpty || domainPart.length > 255) return false;

    // Cannot start or end with hyphen or dot
    if (domainPart.startsWith('-') ||
        domainPart.endsWith('-') ||
        domainPart.startsWith('.') ||
        domainPart.endsWith('.')) {
      return false;
    }

    // Must contain at least one dot
    if (!domainPart.contains('.')) return false;

    // Split by dots and validate each part
    final parts = domainPart.split('.');
    for (final part in parts) {
      if (part.isEmpty || part.length > 63) return false;
      if (part.startsWith('-') || part.endsWith('-')) return false;

      // Valid characters: letters, numbers, and hyphens
      final validChars = RegExp(r'^[a-zA-Z0-9-]+$');
      if (!validChars.hasMatch(part)) return false;
    }

    // TLD should be at least 2 characters and only letters
    final tld = parts.last;
    if (tld.length < 2 || !RegExp(r'^[a-zA-Z]+$').hasMatch(tld)) {
      return false;
    }

    return true;
  }

  /// Validate email and return error message
  static String? validate(String? email) {
    if (email == null || email.isEmpty) {
      return 'Vui lòng nhập địa chỉ email';
    }

    if (!isValid(email)) {
      final suggestion = suggestCorrection(email);
      if (suggestion != null) {
        return 'Email không hợp lệ. Có phải bạn muốn nhập: $suggestion?';
      }
      return 'Địa chỉ email không hợp lệ';
    }

    if (isDisposableEmail(email)) {
      return 'Vui lòng sử dụng địa chỉ email thường xuyên';
    }

    return null;
  }

  /// Generate a masked email for privacy
  static String maskEmail(String email) {
    if (!isValidFormat(email)) return email;

    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) return email;

    final maskedUsername = username[0] +
        '*' * (username.length - 2) +
        username[username.length - 1];

    return '$maskedUsername@$domain';
  }
}
