/// Vietnamese phone number validator
class PhoneValidator {
  PhoneValidator._();

  // Vietnamese mobile prefixes (as of 2024)
  static const List<String> _mobileNetworkPrefixes = [
    // Viettel
    '086', '096', '097', '098', '032', '033', '034', '035', '036', '037', '038',
    '039',
    // Vinaphone
    '088', '091', '094', '083', '084', '085', '081', '082',
    // Mobifone
    '089', '090', '093', '070', '079', '077', '076', '078',
    // Vietnamobile
    '092', '056', '058',
    // Gmobile
    '099', '059',
    // Itelecom
    '087',
  ];

  // Vietnamese landline prefixes by region
  static const Map<String, List<String>> _landlinePrefixes = {
    'Hanoi': ['024'],
    'Ho Chi Minh City': ['028'],
    'Hai Phong': ['0225'],
    'Da Nang': ['0236'],
    'Can Tho': ['0292'],
    'An Giang': ['0296'],
    'Ba Ria - Vung Tau': ['0254'],
    'Bac Giang': ['0204'],
    'Bac Kan': ['0209'],
    'Bac Lieu': ['0291'],
    'Bac Ninh': ['0222'],
    'Ben Tre': ['0275'],
    'Binh Dinh': ['0256'],
    'Binh Duong': ['0274'],
    'Binh Phuoc': ['0271'],
    'Binh Thuan': ['0252'],
    'Ca Mau': ['0290'],
    'Cao Bang': ['0206'],
    'Dak Lak': ['0262'],
    'Dak Nong': ['0261'],
    'Dien Bien': ['0215'],
    'Dong Nai': ['0251'],
    'Dong Thap': ['0277'],
    'Gia Lai': ['0269'],
    'Ha Giang': ['0219'],
    'Ha Nam': ['0226'],
    'Ha Tinh': ['0239'],
    'Hai Duong': ['0220'],
    'Hau Giang': ['0293'],
    'Hoa Binh': ['0218'],
    'Hung Yen': ['0221'],
    'Khanh Hoa': ['0258'],
    'Kien Giang': ['0297'],
    'Kon Tum': ['0260'],
    'Lai Chau': ['0213'],
    'Lam Dong': ['0263'],
    'Lang Son': ['0205'],
    'Lao Cai': ['0214'],
    'Long An': ['0272'],
    'Nam Dinh': ['0228'],
    'Nghe An': ['0238'],
    'Ninh Binh': ['0229'],
    'Ninh Thuan': ['0259'],
    'Phu Tho': ['0210'],
    'Phu Yen': ['0257'],
    'Quang Binh': ['0232'],
    'Quang Nam': ['0235'],
    'Quang Ngai': ['0255'],
    'Quang Ninh': ['0203'],
    'Quang Tri': ['0233'],
    'Soc Trang': ['0299'],
    'Son La': ['0212'],
    'Tay Ninh': ['0276'],
    'Thai Binh': ['0227'],
    'Thai Nguyen': ['0208'],
    'Thanh Hoa': ['0237'],
    'Thua Thien Hue': ['0234'],
    'Tien Giang': ['0273'],
    'Tra Vinh': ['0294'],
    'Tuyen Quang': ['0207'],
    'Vinh Long': ['0270'],
    'Vinh Phuc': ['0211'],
    'Yen Bai': ['0216'],
  };

  /// Check if phone number is valid Vietnamese mobile number
  static bool isValidVietnameseMobile(String phone) {
    final cleanPhone = _cleanPhoneNumber(phone);

    // Must be 10 digits for mobile
    if (cleanPhone.length != 10) return false;

    // Check if starts with valid mobile prefix
    for (final prefix in _mobileNetworkPrefixes) {
      if (cleanPhone.startsWith(prefix)) {
        return true;
      }
    }

    return false;
  }

  /// Check if phone number is valid Vietnamese landline number
  static bool isValidVietnameseLandline(String phone) {
    final cleanPhone = _cleanPhoneNumber(phone);

    // Landline can be 10-11 digits
    if (cleanPhone.length < 10 || cleanPhone.length > 11) return false;

    // Check if starts with valid landline prefix
    for (final prefixes in _landlinePrefixes.values) {
      for (final prefix in prefixes) {
        if (cleanPhone.startsWith(prefix)) {
          return true;
        }
      }
    }

    return false;
  }

  /// Check if phone number is valid Vietnamese number (mobile or landline)
  static bool isValidVietnamese(String phone) {
    return isValidVietnameseMobile(phone) || isValidVietnameseLandline(phone);
  }

  /// Get mobile network provider
  static String? getMobileProvider(String phone) {
    final cleanPhone = _cleanPhoneNumber(phone);

    if (!isValidVietnameseMobile(cleanPhone)) return null;

    final prefix = cleanPhone.substring(0, 3);

    // Viettel
    if ([
      '086',
      '096',
      '097',
      '098',
      '032',
      '033',
      '034',
      '035',
      '036',
      '037',
      '038',
      '039'
    ].contains(prefix)) {
      return 'Viettel';
    }

    // Vinaphone
    if (['088', '091', '094', '083', '084', '085', '081', '082']
        .contains(prefix)) {
      return 'Vinaphone';
    }

    // Mobifone
    if (['089', '090', '093', '070', '079', '077', '076', '078']
        .contains(prefix)) {
      return 'Mobifone';
    }

    // Vietnamobile
    if (['092', '056', '058'].contains(prefix)) {
      return 'Vietnamobile';
    }

    // Gmobile
    if (['099', '059'].contains(prefix)) {
      return 'Gmobile';
    }

    // Itelecom
    if (['087'].contains(prefix)) {
      return 'Itelecom';
    }

    return null;
  }

  /// Get region from landline number
  static String? getLandlineRegion(String phone) {
    final cleanPhone = _cleanPhoneNumber(phone);

    if (!isValidVietnameseLandline(cleanPhone)) return null;

    for (final entry in _landlinePrefixes.entries) {
      for (final prefix in entry.value) {
        if (cleanPhone.startsWith(prefix)) {
          return entry.key;
        }
      }
    }

    return null;
  }

  /// Format Vietnamese phone number
  static String formatVietnamese(String phone) {
    final cleanPhone = _cleanPhoneNumber(phone);

    if (isValidVietnameseMobile(cleanPhone)) {
      // Format: 0XXX XXX XXX
      return '${cleanPhone.substring(0, 4)} ${cleanPhone.substring(4, 7)} ${cleanPhone.substring(7)}';
    }

    if (isValidVietnameseLandline(cleanPhone)) {
      if (cleanPhone.length == 10) {
        // Format: 0XX XXXX XXXX
        return '${cleanPhone.substring(0, 3)} ${cleanPhone.substring(3, 7)} ${cleanPhone.substring(7)}';
      } else {
        // Format: 0XXX XXX XXXX
        return '${cleanPhone.substring(0, 4)} ${cleanPhone.substring(4, 7)} ${cleanPhone.substring(7)}';
      }
    }

    return phone;
  }

  /// Clean phone number (remove spaces, dashes, etc.)
  static String _cleanPhoneNumber(String phone) {
    String cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');

    // Remove country code if present
    if (cleaned.startsWith('+84')) {
      cleaned = '0${cleaned.substring(3)}';
    } else if (cleaned.startsWith('84') && cleaned.length >= 11) {
      cleaned = '0${cleaned.substring(2)}';
    }

    return cleaned;
  }

  /// Convert to international format
  static String toInternationalFormat(String phone) {
    final cleanPhone = _cleanPhoneNumber(phone);

    if (!isValidVietnamese(cleanPhone)) return phone;

    // Remove leading 0 and add +84
    return '+84${cleanPhone.substring(1)}';
  }

  /// Validate phone number and return error message
  static String? validate(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    }

    if (!isValidVietnamese(phone)) {
      return 'Số điện thoại không hợp lệ';
    }

    return null;
  }
}
