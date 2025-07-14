/// Flutter Utils Core
///
/// Essential utilities for Flutter development in Vietnam.
///
/// This package provides:
/// - Vietnamese date/time formatting
/// - Vietnamese text processing (remove tones, validate)
/// - Phone number validation (Vietnamese carriers)
/// - ID card validation (CCCD/CMND)
/// - Currency formatting (VND)
/// - Device information helpers
/// - Connectivity utilities
/// - Navigation helpers
/// - Logging utilities
/// - String extensions
/// - Number extensions
/// - DateTime extensions
///
/// ## Usage
///
/// ```dart
/// import 'package:flutter_utils_core/flutter_utils_core.dart';
///
/// // Date formatting
/// final dateStr = DateTime.now().toVietnameseString(); // "12/03/2024"
/// final dateStr2 = DateTime.now().toFullVietnameseString(); // "Thứ hai, 12 tháng 3 năm 2024"
///
/// // Vietnamese text processing
/// final normalized = "Đây là tiếng Việt".removeVietnameseTones(); // "Day la tieng Viet"
///
/// // Phone validation
/// final isValid = PhoneValidator.isValidVietnamese("0912345678"); // true
///
/// // Number formatting
/// final price = 1000000.toVND(); // "1.000.000 ₫"
/// final compact = 1500000.toCompactVND(); // "1,5M ₫"
///
/// // Device info
/// final deviceInfo = await DeviceHelper.getDeviceInfo();
/// final isTablet = DeviceHelper.isTablet(context);
///
/// // Connectivity
/// final hasInternet = await ConnectivityHelper.hasInternetConnection();
///
/// // Validation
/// final phoneError = Validators.phone("0912345678"); // null if valid
/// final emailError = Validators.email("test@example.com"); // null if valid
/// ```
library flutter_utils_core;

// Extensions
export 'src/extensions/string_extensions.dart';
export 'src/extensions/number_extensions.dart';
export 'src/extensions/datetime_extensions.dart';
export 'src/extensions/widget_extensions.dart';
export 'src/extensions/list_extensions.dart';

// Validators
export 'src/validators/phone_validator.dart';
export 'src/validators/id_card_validator.dart';
export 'src/validators/email_validator.dart';
export 'src/validators/validators.dart';

// Formatters
export 'src/formatters/currency_formatter.dart';
export 'src/formatters/date_formatter.dart';
export 'src/formatters/number_formatter.dart';
export 'src/formatters/text_formatter.dart';

// Helpers
export 'src/helpers/device_helper.dart';
export 'src/helpers/connectivity_helper.dart';
export 'src/helpers/navigation_helper.dart';
export 'src/helpers/logger_helper.dart';
export 'src/helpers/file_helper.dart';
export 'src/helpers/image_helper.dart';
export 'src/helpers/sharing_helper.dart';

// Constants
export 'src/constants/vietnamese_constants.dart';
export 'src/constants/app_constants.dart';
export 'src/constants/regex_constants.dart';

// Mixins
export 'src/mixins/loading_mixin.dart';
export 'src/mixins/validation_mixin.dart';
export 'src/mixins/connectivity_mixin.dart';
