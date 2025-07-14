# Flutter Utils Core 🛠️

Essential utilities for Flutter development in Vietnam - Date formatting, validation, Vietnamese text processing, and more.

## ✨ Features

- **🇻🇳 Vietnamese Localization** - Complete Vietnamese date/time formatting, text processing
- **📱 Device Utilities** - Device info, screen size detection, platform checks
- **✅ Smart Validation** - Vietnamese phone numbers, ID cards, emails with localized messages
- **📝 String Extensions** - Remove Vietnamese tones, format phone numbers, text processing
- **📊 Number Formatting** - Vietnamese currency (VND), compact numbers, percentage
- **📅 DateTime Extensions** - Vietnamese relative time, business days, age calculation
- **🔧 Helper Classes** - Connectivity, navigation, logging, file operations
- **📋 Form Validators** - Ready-to-use form validation functions

## 🚀 Quick Start

### Installation

```yaml
dependencies:
  flutter_utils_core: ^1.0.0
```

### Basic Usage

```dart
import 'package:flutter_utils_core/flutter_utils_core.dart';

// Vietnamese text processing
final normalized = "Đây là tiếng Việt".removeVietnameseTones(); // "Day la tieng Viet"
final searchable = "Nguyễn Văn A".toSearchFormat(); // "nguyen van a"
final proper = "nguyễn văn a".toProperCase(); // "Nguyễn Văn A"

// Phone number validation & formatting
final isValid = "0912345678".isValidVietnamesePhone; // true
final formatted = "0912345678".formatVietnamesePhone(); // "091 234 5678"
final carrier = VietnameseConstants.getCarrierName("0912345678"); // "Viettel"

// Vietnamese currency formatting
final price = 1000000.toVND(); // "1.000.000 ₫"
final compact = 1500000.toCompactVND(); // "1,5M ₫"

// Vietnamese date formatting
final date = DateTime.now().toVietnameseString(); // "12/03/2024"
final fullDate = DateTime.now().toFullVietnameseString(); // "Thứ hai, 12 tháng 3 năm 2024"
final relative = DateTime.now().subtract(Duration(hours: 2)).toVietnameseRelativeTime(); // "2 giờ trước"

// Device information
final deviceInfo = await DeviceHelper.getDeviceInfo();
final isTablet = DeviceHelper.isTablet(context);
final hasInternet = await ConnectivityHelper.hasInternetConnection();
```

## 📚 Detailed Documentation

### 🔤 String Extensions

```dart
// Vietnamese text processing
"Đây là tiếng Việt".removeVietnameseTones(); // "Day la tieng Viet"
"tiếng việt".toProperCase(); // "Tiếng Việt"
"Nguyễn Văn A".toSearchFormat(); // "nguyen van a"
"test@email.com".isValidEmail; // true
"0912345678".isValidVietnamesePhone; // true

// Formatting
"0912345678".formatVietnamesePhone(); // "091 234 5678"
"123456789".formatVietnameseId(); // "123 456 789"
"Nguyễn Văn A".initials; // "NVA"
"Very long text here".truncate(10); // "Very long..."

// Utility
"hello world".toSlug(); // "hello-world"
"0912345678".mask(start: 3, end: 3); // "091*****678"
"Price: 1,000,000 VND".numbersOnly; // "1000000"
```

### 🔢 Number Extensions

```dart
// Vietnamese currency
1000000.toVND(); // "1.000.000 ₫"
1500000.toCompactVND(); // "1,5M ₫"
1000000.toFormattedString(); // "1.000.000"

// Utility
1024.toBytesString(); // "1 KB"
90000.toVietnameseDuration(); // "1 phút 30 giây"
5.toVietnameseOrdinal(); // "thứ năm"

// Double extensions
0.15.toVietnamesePercentage(); // "15%"
1500.0.toCompactString(); // "1.5K"
```

### 📅 DateTime Extensions

```dart
// Vietnamese formatting
DateTime.now().toVietnameseString(); // "12/03/2024"
DateTime.now().toVietnameseDateTimeString(); // "12/03/2024 14:30"
DateTime.now().toFullVietnameseString(); // "Thứ hai, 12 tháng 3 năm 2024"
DateTime.now().toVietnameseMonthYear(); // "tháng 3 năm 2024"

// Relative time
DateTime.now().subtract(Duration(minutes: 30)).toVietnameseRelativeTime(); // "30 phút trước"
DateTime.now().subtract(Duration(days: 1)).toVietnameseRelativeTime(); // "hôm qua"

// Utility checks
DateTime.now().isToday; // true
DateTime.now().isWeekend; // depends on day
DateTime.now().age; // years since this date

// Date manipulations
DateTime.now().startOfDay; // 00:00:00 today
DateTime.now().endOfMonth; // last day of month 23:59:59
DateTime.now().addBusinessDays(5); // skip weekends
DateTime.now().vietnameseZodiac; // "Thìn" (example)
```

### ✅ Validation

```dart
// Form validators (return error message or null)
Validators.required(""); // "Trường này là bắt buộc"
Validators.email("invalid-email"); // "Email không hợp lệ"
Validators.phone("123"); // "Số điện thoại không hợp lệ"
Validators.idCard("123"); // "CCCD/CMND không hợp lệ"
Validators.password("123"); // "Mật khẩu phải có ít nhất 6 ký tự"

// Combine validators
final validator = Validators.combine([
  Validators.required,
  (value) => Validators.minLength(value, 8, 'Mật khẩu'),
]);

// Usage in forms
TextFormField(
  validator: Validators.email,
  decoration: InputDecoration(labelText: 'Email'),
)
```

### 📱 Device Helpers

```dart
// Device information
final deviceInfo = await DeviceHelper.getDeviceInfo();
final model = await DeviceHelper.getDeviceModel(); // "Samsung Galaxy S21"
final osVersion = await DeviceHelper.getOSVersion(); // "Android 13"
final isPhysical = await DeviceHelper.isPhysicalDevice(); // true

// Screen information
final isTablet = DeviceHelper.isTablet(context);
final screenSize = DeviceHelper.getScreenSize(context); // ScreenSize.small/medium/large
final hasNotch = DeviceHelper.hasNotch(context);
final safeArea = DeviceHelper.getSafeAreaPadding(context);

// Platform checks
DeviceHelper.isAndroid; // true/false
DeviceHelper.isIOS; // true/false
DeviceHelper.isMobile; // true/false
DeviceHelper.isDesktop; // true/false
```

### 🌐 Connectivity Helper

```dart
// Check connectivity
final hasInternet = await ConnectivityHelper.hasInternetConnection();
final connectionType = await ConnectivityHelper.getConnectionType();
// ConnectionType.wifi, ConnectionType.mobile, ConnectionType.none

// Listen to connectivity changes
ConnectivityHelper.onConnectivityChanged.listen((isConnected) {
  if (isConnected) {
    print('Connected to internet');
  } else {
    print('No internet connection');
  }
});
```

### 🇻🇳 Vietnamese Constants

```dart
// Phone carriers
VietnameseConstants.getCarrierName("0912345678"); // "Viettel"
VietnameseConstants.phoneCarrierPrefixes; // List of all prefixes

// Date/time
VietnameseConstants.daysOfWeek; // ["Thứ hai", "Thứ ba", ...]
VietnameseConstants.months; // ["tháng 1", "tháng 2", ...]

// Provinces
VietnameseConstants.provinces; // All Vietnamese provinces
VietnameseConstants.isValidProvince("Hà Nội"); // true

// Zodiac
VietnameseConstants.zodiacAnimals; // ["Tý (Chuột)", "Sửu (Trâu)", ...]
```

## 🎯 Real-World Examples

### Form Validation

```dart
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: Validators.combine([
              Validators.required,
              Validators.phone,
            ]),
            decoration: InputDecoration(
              labelText: 'Số điện thoại',
              hintText: '0912345678',
            ),
          ),
          TextFormField(
            validator: Validators.combine([
              Validators.required,
              (value) => Validators.minLength(value, 6, 'Mật khẩu'),
            ]),
            obscureText: true,
            decoration: InputDecoration(labelText: 'Mật khẩu'),
          ),
        ],
      ),
    );
  }
}
```

### Vietnamese Text Search

```dart
class UserSearch {
  static List<User> searchUsers(List<User> users, String query) {
    final searchQuery = query.toSearchFormat();
    
    return users.where((user) {
      final userName = user.name.toSearchFormat();
      final userPhone = user.phone.removeVietnameseTones();
      
      return userName.contains(searchQuery) || 
             userPhone.contains(searchQuery);
    }).toList();
  }
}
```

### Currency Display

```dart
class PriceWidget extends StatelessWidget {
  final int price;
  final bool compact;
  
  const PriceWidget({Key? key, required this.price, this.compact = false}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      compact ? price.toCompactVND() : price.toVND(),
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }
}
```

### Responsive Layout

```dart
class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = DeviceHelper.getScreenSize(context);
    final isTablet = DeviceHelper.isTablet(context);
    
    return Scaffold(
      body: screenSize == ScreenSize.small
          ? _buildMobileLayout()
          : isTablet
              ? _buildTabletLayout()
              : _buildDesktopLayout(),
    );
  }
}
```

## 🧪 Testing

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_utils_core/flutter_utils_core.dart';

void main() {
  group('Vietnamese Text Processing', () {
    test('should remove Vietnamese tones correctly', () {
      expect("Đây là tiếng Việt".removeVietnameseTones(), "Day la tieng Viet");
    });
    
    test('should format phone number correctly', () {
      expect("0912345678".formatVietnamesePhone(), "091 234 5678");
    });
  });
  
  group('Validation', () {
    test('should validate Vietnamese phone numbers', () {
      expect(Validators.phone("0912345678"), null);
      expect(Validators.phone("123"), isNotNull);
    });
  });
}
```

## 📱 Platform Support

- ✅ Android
- ✅ iOS  
- ✅ Web
- ✅ Desktop (Windows, macOS, Linux)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for your changes
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Vietnamese Flutter community
- Contributors and testers
- Open source packages that inspired this work
