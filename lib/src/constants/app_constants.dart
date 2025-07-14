/// Application constants
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'Flutter Utils Core';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Essential utilities for Flutter development in Vietnam';

  // Vietnamese Locale
  static const String vietnameseLocale = 'vi_VN';
  static const String vietnameseLanguageCode = 'vi';
  static const String vietnameseCountryCode = 'VN';

  // Date Formats
  static const String vietnameseDateFormat = 'dd/MM/yyyy';
  static const String vietnameseTimeFormat = 'HH:mm';
  static const String vietnameseDateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String vietnameseFullDateFormat = 'EEEE, dd MMMM yyyy';

  // Currency
  static const String vietnameseCurrency = 'VND';
  static const String vietnameseCurrencySymbol = '₫';

  // Phone Number Formats
  static const String vietnamesePhoneFormat = '+84';
  static const int vietnamesePhoneLength = 10;
  static const int vietnamesePhoneLengthWithCode = 12;

  // ID Card Formats
  static const int cccdLength = 12;
  static const int cmndLength = 9;

  // Common Timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration shortTimeout = Duration(seconds: 10);
  static const Duration longTimeout = Duration(minutes: 2);

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Common Sizes
  static const double smallPadding = 8.0;
  static const double normalPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;

  static const double smallMargin = 8.0;
  static const double normalMargin = 16.0;
  static const double largeMargin = 24.0;
  static const double extraLargeMargin = 32.0;

  static const double smallRadius = 4.0;
  static const double normalRadius = 8.0;
  static const double largeRadius = 12.0;
  static const double extraLargeRadius = 16.0;

  static const double smallElevation = 2.0;
  static const double normalElevation = 4.0;
  static const double largeElevation = 8.0;

  // Icon Sizes
  static const double smallIconSize = 16.0;
  static const double normalIconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double extraLargeIconSize = 48.0;

  // Font Sizes
  static const double smallFontSize = 12.0;
  static const double normalFontSize = 14.0;
  static const double largeFontSize = 16.0;
  static const double extraLargeFontSize = 18.0;
  static const double titleFontSize = 20.0;
  static const double headlineFontSize = 24.0;

  // Device Breakpoints
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;

  // Network
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // File Sizes
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxVideoSize = 100 * 1024 * 1024; // 100MB
  static const int maxDocumentSize = 50 * 1024 * 1024; // 50MB

  // Common Vietnamese Words
  static const List<String> vietnameseStopWords = [
    'và',
    'của',
    'với',
    'trong',
    'là',
    'có',
    'để',
    'được',
    'một',
    'các',
    'những',
    'này',
    'đó',
    'khi',
    'nếu',
    'như',
    'từ',
    'cho',
    'về',
    'theo',
    'sau',
    'trước',
    'tại',
    'bởi',
    'vì',
    'do',
    'nên',
    'mà',
    'rằng',
    'thì'
  ];

  // Vietnamese Provinces
  static const List<String> vietnameseProvinces = [
    'An Giang',
    'Bà Rịa - Vũng Tàu',
    'Bắc Giang',
    'Bắc Kạn',
    'Bạc Liêu',
    'Bắc Ninh',
    'Bến Tre',
    'Bình Định',
    'Bình Dương',
    'Bình Phước',
    'Bình Thuận',
    'Cà Mau',
    'Cần Thơ',
    'Cao Bằng',
    'Đà Nẵng',
    'Đắk Lắk',
    'Đắk Nông',
    'Điện Biên',
    'Đồng Nai',
    'Đồng Tháp',
    'Gia Lai',
    'Hà Giang',
    'Hà Nam',
    'Hà Nội',
    'Hà Tĩnh',
    'Hải Dương',
    'Hải Phòng',
    'Hậu Giang',
    'Hòa Bình',
    'Hưng Yên',
    'Khánh Hòa',
    'Kiên Giang',
    'Kon Tum',
    'Lai Châu',
    'Lâm Đồng',
    'Lạng Sơn',
    'Lào Cai',
    'Long An',
    'Nam Định',
    'Nghệ An',
    'Ninh Bình',
    'Ninh Thuận',
    'Phú Thọ',
    'Phú Yên',
    'Quảng Bình',
    'Quảng Nam',
    'Quảng Ngãi',
    'Quảng Ninh',
    'Quảng Trị',
    'Sóc Trăng',
    'Sơn La',
    'Tây Ninh',
    'Thái Bình',
    'Thái Nguyên',
    'Thanh Hóa',
    'Thừa Thiên Huế',
    'Tiền Giang',
    'TP Hồ Chí Minh',
    'Trà Vinh',
    'Tuyên Quang',
    'Vĩnh Long',
    'Vĩnh Phúc',
    'Yên Bái'
  ];

  // HTTP Status Codes
  static const int httpOk = 200;
  static const int httpCreated = 201;
  static const int httpBadRequest = 400;
  static const int httpUnauthorized = 401;
  static const int httpForbidden = 403;
  static const int httpNotFound = 404;
  static const int httpInternalServerError = 500;

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String settingsKey = 'app_settings';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';

  // Error Messages (Vietnamese)
  static const String unknownError = 'Đã xảy ra lỗi không xác định';
  static const String networkError = 'Lỗi kết nối mạng';
  static const String serverError = 'Lỗi máy chủ';
  static const String timeoutError = 'Hết thời gian chờ';
  static const String noInternetError = 'Không có kết nối internet';
  static const String invalidDataError = 'Dữ liệu không hợp lệ';
  static const String permissionDeniedError = 'Không có quyền truy cập';

  // Success Messages (Vietnamese)
  static const String saveSuccessMessage = 'Lưu thành công';
  static const String deleteSuccessMessage = 'Xóa thành công';
  static const String updateSuccessMessage = 'Cập nhật thành công';
  static const String uploadSuccessMessage = 'Tải lên thành công';
  static const String downloadSuccessMessage = 'Tải xuống thành công';

  // Common Actions (Vietnamese)
  static const String confirmAction = 'Xác nhận';
  static const String cancelAction = 'Hủy';
  static const String saveAction = 'Lưu';
  static const String deleteAction = 'Xóa';
  static const String editAction = 'Sửa';
  static const String addAction = 'Thêm';
  static const String searchAction = 'Tìm kiếm';
  static const String filterAction = 'Lọc';
  static const String sortAction = 'Sắp xếp';
  static const String refreshAction = 'Làm mới';

  // Validation Messages (Vietnamese)
  static const String requiredFieldMessage = 'Trường này là bắt buộc';
  static const String invalidEmailMessage = 'Email không hợp lệ';
  static const String invalidPhoneMessage = 'Số điện thoại không hợp lệ';
  static const String invalidPasswordMessage = 'Mật khẩu không hợp lệ';
  static const String passwordTooShortMessage = 'Mật khẩu quá ngắn';
  static const String passwordMismatchMessage = 'Mật khẩu không khớp';

  // Loading Messages (Vietnamese)
  static const String loadingMessage = 'Đang tải...';
  static const String processingMessage = 'Đang xử lý...';
  static const String uploadingMessage = 'Đang tải lên...';
  static const String downloadingMessage = 'Đang tải xuống...';
  static const String savingMessage = 'Đang lưu...';

  // Empty State Messages (Vietnamese)
  static const String noDataMessage = 'Không có dữ liệu';
  static const String noResultsMessage = 'Không tìm thấy kết quả';
  static const String emptyListMessage = 'Danh sách trống';
  static const String noInternetMessage = 'Không có kết nối internet';

  // Date/Time Labels (Vietnamese)
  static const String todayLabel = 'Hôm nay';
  static const String yesterdayLabel = 'Hôm qua';
  static const String tomorrowLabel = 'Ngày mai';
  static const String thisWeekLabel = 'Tuần này';
  static const String lastWeekLabel = 'Tuần trước';
  static const String thisMonthLabel = 'Tháng này';
  static const String lastMonthLabel = 'Tháng trước';
  static const String thisYearLabel = 'Năm nay';
  static const String lastYearLabel = 'Năm ngoái';
}
