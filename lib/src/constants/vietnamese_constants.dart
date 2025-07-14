/// Vietnamese language constants and locale-specific data
class VietnameseConstants {
  // ============================================================================
  // VIETNAMESE CHARACTER MAPPING
  // ============================================================================

  /// Vietnamese characters with diacritics
  static const List<String> vietnameseChars = [
    'aàáạảãâầấậẩẫăằắặẳẵ',
    'AÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ',
    'dđ',
    'DĐ',
    'eèéẹẻẽêềếệểễ',
    'EÈÉẸẺẼÊỀẾỆỂỄ',
    'iìíịỉĩ',
    'IÌÍỊỈĨ',
    'oòóọỏõôồốộổỗơờớợởỡ',
    'OÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ',
    'uùúụủũưừứựửữ',
    'UÙÚỤỦŨƯỪỨỰỬỮ',
    'yỳýỵỷỹ',
    'YỲÝỴỶỸ'
  ];

  /// Corresponding normal characters (without diacritics)
  static const List<String> normalChars = [
    'aaaaaaaaaaaaaaaa',
    'AAAAAAAAAAAAAAAA',
    'dd',
    'DD',
    'eeeeeeeeeee',
    'EEEEEEEEEEE',
    'iiiii',
    'IIIII',
    'oooooooooooooooooo',
    'OOOOOOOOOOOOOOOOOO',
    'uuuuuuuuuuu',
    'UUUUUUUUUUU',
    'yyyyyy',
    'YYYYYY'
  ];

  // ============================================================================
  // VIETNAMESE PHONE CARRIERS
  // ============================================================================

  /// Vietnamese mobile carrier prefixes
  static const List<String> phoneCarrierPrefixes = [
    // Viettel
    '032', '033', '034', '035', '036', '037', '038', '039',
    '086', '096', '097', '098',

    // VinaPhone
    '081', '082', '083', '084', '085', '088',
    '091', '094',

    // MobiFone
    '070', '076', '077', '078', '079', '089',
    '090', '093',

    // Vietnamobile
    '052', '056', '058', '092',

    // Gmobile
    '059', '099',

    // Itelecom
    '087',

    // Reddi
    '055',
  ];

  /// Vietnamese carrier names
  static const Map<String, String> carrierNames = {
    '032': 'Viettel',
    '033': 'Viettel',
    '034': 'Viettel',
    '035': 'Viettel',
    '036': 'Viettel',
    '037': 'Viettel',
    '038': 'Viettel',
    '039': 'Viettel',
    '086': 'Viettel',
    '096': 'Viettel',
    '097': 'Viettel',
    '098': 'Viettel',
    '081': 'VinaPhone',
    '082': 'VinaPhone',
    '083': 'VinaPhone',
    '084': 'VinaPhone',
    '085': 'VinaPhone',
    '088': 'VinaPhone',
    '091': 'VinaPhone',
    '094': 'VinaPhone',
    '070': 'MobiFone',
    '076': 'MobiFone',
    '077': 'MobiFone',
    '078': 'MobiFone',
    '079': 'MobiFone',
    '089': 'MobiFone',
    '090': 'MobiFone',
    '093': 'MobiFone',
    '052': 'Vietnamobile',
    '056': 'Vietnamobile',
    '058': 'Vietnamobile',
    '092': 'Vietnamobile',
    '059': 'Gmobile',
    '099': 'Gmobile',
    '087': 'Itelecom',
    '055': 'Reddi',
  };

  // ============================================================================
  // VIETNAMESE DATE/TIME
  // ============================================================================

  /// Days of week in Vietnamese (Monday = 0)
  static const List<String> daysOfWeek = [
    'Thứ hai',
    'Thứ ba',
    'Thứ tư',
    'Thứ năm',
    'Thứ sáu',
    'Thứ bảy',
    'Chủ nhật',
  ];

  /// Short days of week in Vietnamese
  static const List<String> shortDaysOfWeek = [
    'T2',
    'T3',
    'T4',
    'T5',
    'T6',
    'T7',
    'CN'
  ];

  /// Months in Vietnamese
  static const List<String> months = [
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
    'tháng 12'
  ];

  /// Short months in Vietnamese
  static const List<String> shortMonths = [
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
    'Th12'
  ];

  // ============================================================================
  // VIETNAMESE PROVINCES
  // ============================================================================

  /// Vietnamese provinces and cities
  static const List<String> provinces = [
    'An Giang', 'Bà Rịa - Vũng Tàu', 'Bắc Giang', 'Bắc Kạn', 'Bạc Liêu',
    'Bắc Ninh', 'Bến Tre', 'Bình Định', 'Bình Dương', 'Bình Phước',
    'Bình Thuận', 'Cà Mau', 'Cao Bằng', 'Đắk Lắk', 'Đắk Nông',
    'Điện Biên', 'Đồng Nai', 'Đồng Tháp', 'Gia Lai', 'Hà Giang',
    'Hà Nam', 'Hà Tĩnh', 'Hải Dương', 'Hậu Giang', 'Hòa Bình',
    'Hưng Yên', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum', 'Lai Châu',
    'Lâm Đồng', 'Lạng Sơn', 'Lào Cai', 'Long An', 'Nam Định',
    'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ', 'Quảng Bình',
    'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị', 'Sóc Trăng',
    'Sơn La', 'Tây Ninh', 'Thái Bình', 'Thái Nguyên', 'Thanh Hóa',
    'Thừa Thiên Huế', 'Tiền Giang', 'Trà Vinh', 'Tuyên Quang', 'Vĩnh Long',
    'Vĩnh Phúc', 'Yên Bái', 'Phú Yên',

    // Major cities
    'Hà Nội', 'TP. Hồ Chí Minh', 'Đà Nẵng', 'Hải Phòng', 'Cần Thơ'
  ];

  // ============================================================================
  // VIETNAMESE ZODIAC
  // ============================================================================

  /// Vietnamese zodiac animals
  static const List<String> zodiacAnimals = [
    'Tý (Chuột)',
    'Sửu (Trâu)',
    'Dần (Hổ)',
    'Mão (Mèo)',
    'Thìn (Rồng)',
    'Tỵ (Rắn)',
    'Ngọ (Ngựa)',
    'Mùi (Dê)',
    'Thân (Khỉ)',
    'Dậu (Gà)',
    'Tuất (Chó)',
    'Hợi (Heo)'
  ];

  // ============================================================================
  // COMMON VIETNAMESE WORDS
  // ============================================================================

  /// Common Vietnamese titles
  static const List<String> titles = [
    'Anh',
    'Chị',
    'Em',
    'Ông',
    'Bà',
    'Cô',
    'Chú',
    'Bác'
  ];

  /// Vietnamese family relationships
  static const Map<String, String> familyRelationships = {
    'father': 'Bố',
    'mother': 'Mẹ',
    'son': 'Con trai',
    'daughter': 'Con gái',
    'husband': 'Chồng',
    'wife': 'Vợ',
    'brother': 'Anh trai',
    'sister': 'Chị gái',
    'grandfather': 'Ông',
    'grandmother': 'Bà',
    'uncle': 'Chú',
    'aunt': 'Cô',
  };

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Get carrier name from phone number
  static String? getCarrierName(String phoneNumber) {
    final digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (digits.length == 10 && digits.startsWith('0')) {
      final prefix = digits.substring(0, 3);
      return carrierNames[prefix];
    }

    if (digits.length == 11 && digits.startsWith('84')) {
      final prefix = '0${digits.substring(2, 4)}';
      return carrierNames[prefix];
    }

    return null;
  }

  /// Check if province name is valid
  static bool isValidProvince(String province) {
    return provinces.any((p) => p.toLowerCase() == province.toLowerCase());
  }
}
