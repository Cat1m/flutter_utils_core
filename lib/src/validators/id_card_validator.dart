/// Vietnamese ID card (CCCD/CMND) validator
class IdCardValidator {
  IdCardValidator._();

  // Province codes for CCCD (Citizen ID)
  static const Map<String, String> _provinceCodes = {
    '001': 'Hà Nội',
    '002': 'Hà Giang',
    '004': 'Cao Bằng',
    '006': 'Bắc Kạn',
    '008': 'Tuyên Quang',
    '010': 'Lào Cai',
    '011': 'Điện Biên',
    '012': 'Lai Châu',
    '014': 'Sơn La',
    '015': 'Yên Bái',
    '017': 'Hoà Bình',
    '019': 'Thái Nguyên',
    '020': 'Lạng Sơn',
    '022': 'Quảng Ninh',
    '024': 'Bắc Giang',
    '025': 'Phú Thọ',
    '026': 'Vĩnh Phúc',
    '027': 'Bắc Ninh',
    '030': 'Hải Dương',
    '031': 'Hải Phòng',
    '033': 'Hưng Yên',
    '034': 'Thái Bình',
    '035': 'Hà Nam',
    '036': 'Nam Định',
    '037': 'Ninh Bình',
    '038': 'Thanh Hóa',
    '040': 'Nghệ An',
    '042': 'Hà Tĩnh',
    '044': 'Quảng Bình',
    '045': 'Quảng Trị',
    '046': 'Thừa Thiên Huế',
    '048': 'Đà Nẵng',
    '049': 'Quảng Nam',
    '051': 'Quảng Ngãi',
    '052': 'Bình Định',
    '054': 'Phú Yên',
    '056': 'Khánh Hòa',
    '058': 'Ninh Thuận',
    '060': 'Bình Thuận',
    '062': 'Kon Tum',
    '064': 'Gia Lai',
    '066': 'Đắk Lắk',
    '067': 'Đắk Nông',
    '068': 'Lâm Đồng',
    '070': 'Bình Phước',
    '072': 'Tây Ninh',
    '074': 'Bình Dương',
    '075': 'Đồng Nai',
    '077': 'Bà Rịa - Vũng Tàu',
    '079': 'Hồ Chí Minh',
    '080': 'Long An',
    '082': 'Tiền Giang',
    '083': 'Bến Tre',
    '084': 'Trà Vinh',
    '086': 'Vĩnh Long',
    '087': 'Đồng Tháp',
    '089': 'An Giang',
    '091': 'Kiên Giang',
    '092': 'Cần Thơ',
    '093': 'Hậu Giang',
    '094': 'Sóc Trăng',
    '095': 'Bạc Liêu',
    '096': 'Cà Mau',
  };

  /// Check if string is valid CCCD (12 digits)
  static bool isValidCCCD(String id) {
    final cleanId = id.replaceAll(RegExp(r'[^\d]'), '');

    // CCCD must be exactly 12 digits
    if (cleanId.length != 12) return false;

    // Check if province code is valid
    final provinceCode = cleanId.substring(0, 3);
    if (!_provinceCodes.containsKey(provinceCode)) return false;

    // Check gender code (4th digit: 0-9)
    final genderCode = cleanId[3];
    if (!RegExp(r'[0-9]').hasMatch(genderCode)) return false;

    return true;
  }

  /// Check if string is valid CMND (9 digits)
  static bool isValidCMND(String id) {
    final cleanId = id.replaceAll(RegExp(r'[^\d]'), '');

    // CMND must be exactly 9 digits
    return cleanId.length == 9 && RegExp(r'^\d{9}$').hasMatch(cleanId);
  }

  /// Check if string is valid Vietnamese ID (CCCD or CMND)
  static bool isValidVietnameseId(String id) {
    return isValidCCCD(id) || isValidCMND(id);
  }

  /// Get ID type (CCCD, CMND, or null if invalid)
  static String? getIdType(String id) {
    if (isValidCCCD(id)) return 'CCCD';
    if (isValidCMND(id)) return 'CMND';
    return null;
  }

  /// Extract province from CCCD
  static String? getProvinceFromCCCD(String id) {
    if (!isValidCCCD(id)) return null;

    final cleanId = id.replaceAll(RegExp(r'[^\d]'), '');
    final provinceCode = cleanId.substring(0, 3);
    return _provinceCodes[provinceCode];
  }

  /// Extract gender from CCCD
  static String? getGenderFromCCCD(String id) {
    if (!isValidCCCD(id)) return null;

    final cleanId = id.replaceAll(RegExp(r'[^\d]'), '');
    final genderCode = int.parse(cleanId[3]);

    // Even numbers (0,2,4,6,8) = Female, Odd numbers (1,3,5,7,9) = Male
    return genderCode % 2 == 0 ? 'Nữ' : 'Nam';
  }

  /// Extract birth year from CCCD
  static int? getBirthYearFromCCCD(String id) {
    if (!isValidCCCD(id)) return null;

    final cleanId = id.replaceAll(RegExp(r'[^\d]'), '');
    final genderCode = int.parse(cleanId[3]);
    final yearDigits = cleanId.substring(4, 6);

    // Determine century based on gender code
    int century;
    if (genderCode >= 0 && genderCode <= 1) {
      century = 1900; // Born in 1900-1999
    } else if (genderCode >= 2 && genderCode <= 3) {
      century = 2000; // Born in 2000-2099
    } else if (genderCode >= 4 && genderCode <= 5) {
      century = 2100; // Born in 2100-2199
    } else if (genderCode >= 6 && genderCode <= 7) {
      century = 2200; // Born in 2200-2299
    } else {
      century = 2300; // Born in 2300-2399
    }

    return century + int.parse(yearDigits);
  }

  /// Format ID card number
  static String formatId(String id) {
    final cleanId = id.replaceAll(RegExp(r'[^\d]'), '');

    if (isValidCCCD(cleanId)) {
      // Format CCCD: XXX XXX XXX XXX
      return '${cleanId.substring(0, 3)} ${cleanId.substring(3, 6)} ${cleanId.substring(6, 9)} ${cleanId.substring(9)}';
    }

    if (isValidCMND(cleanId)) {
      // Format CMND: XXX XXX XXX
      return '${cleanId.substring(0, 3)} ${cleanId.substring(3, 6)} ${cleanId.substring(6)}';
    }

    return id;
  }

  /// Get detailed info from CCCD
  static Map<String, dynamic>? getCCCDInfo(String id) {
    if (!isValidCCCD(id)) return null;

    return {
      'type': 'CCCD',
      'province': getProvinceFromCCCD(id),
      'gender': getGenderFromCCCD(id),
      'birthYear': getBirthYearFromCCCD(id),
      'formatted': formatId(id),
    };
  }

  /// Validate ID and return error message
  static String? validate(String? id) {
    if (id == null || id.isEmpty) {
      return 'Vui lòng nhập số CCCD/CMND';
    }

    if (!isValidVietnameseId(id)) {
      return 'Số CCCD/CMND không hợp lệ';
    }

    return null;
  }

  /// Check if person is adult (18+) based on CCCD
  static bool isAdult(String id) {
    final birthYear = getBirthYearFromCCCD(id);
    if (birthYear == null) return false;

    final currentYear = DateTime.now().year;
    return (currentYear - birthYear) >= 18;
  }

  /// Calculate age from CCCD
  static int? getAge(String id) {
    final birthYear = getBirthYearFromCCCD(id);
    if (birthYear == null) return null;

    return DateTime.now().year - birthYear;
  }
}
