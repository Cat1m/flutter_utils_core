// /// Regular expression constants for validation
// class RegexConstants {
//   RegexConstants._();

//   // Email Patterns
//   static const String basicEmail = r'^[^\s@]+@[^\s@]+\.[^\s@]+;
//   static const String strictEmail = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,};

//   // Vietnamese Phone Numbers
//   static const String vietnamesePhone = r'^(\+84|0)[0-9]{8,9};
//   static const String vietnameseMobile = r'^((\+84|0)(32|33|34|35|36|37|38|39|56|58|59|70|76|77|78|79|81|82|83|84|85|86|87|88|89|90|91|92|93|94|96|97|98|99))[0-9]{7};
//   static const String vietnameseLandline = r'^((\+84|0)(2[0-9]{1,2}))[0-9]{6,8};

//   // Vietnamese ID Cards
//   static const String cccd = r'^[0-9]{12};
//   static const String cmnd = r'^[0-9]{9};
//   static const String vietnameseId = r'^[0-9]{9}|[0-9]{12};

//   // Password Patterns
//   static const String weakPassword = r'^.{6,};
//   static const String mediumPassword = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,};
//   static const String strongPassword = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,};

//   // Numbers
//   static const String positiveInteger = r'^[1-9]\d*;
//   static const String nonNegativeInteger = r'^(0|[1-9]\d*);
//   static const String decimal = r'^\d+(\.\d+)?;
//   static const String vietnameseNumber = r'^\d{1,3}(\.\d{3})*(\,\d+)?;

//   // Vietnamese Text
//   static const String vietnameseCharacters = r'[àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬÈÉẺẼẸÊỀẾỂỄỆÌÍỈĨỊÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴĐa-zA-Z]';
//   static const String vietnameseWords = r'^[àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬÈÉẺẼẸÊỀẾỂỄỆÌÍỈĨỊÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴĐa-zA-Z\s]+;
//   static const String vietnameseName = r'^[àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬÈÉẺẼẸÊỀẾỂỄỆÌÍỈĨỊÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴĐa-zA-Z\s]{2,50};

//   // URLs and Links
//   static const String basicUrl = r'^https?:\/\/[^\s/$.?#].[^\s]*;
//   static const String strictUrl = r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*);
//   static const String domain = r'^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9](?:\.[a-zA-Z]{2,})+;

//   // Social Media
//   static const String facebookUrl = r'^https:\/\/(www\.)?facebook\.com\/[a-zA-Z0-9\.]+\/?;
//   static const String youtubeUrl = r'^https:\/\/(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)[a-zA-Z0-9_-]+;
//   static const String instagramUrl = r'^https:\/\/(www\.)?instagram\.com\/[a-zA-Z0-9_.]+\/?;

//   // File Extensions
//   static const String imageFile = r'\.(jpg|jpeg|png|gif|bmp|webp);
//   static const String videoFile = r'\.(mp4|avi|mov|wmv|flv|webm|mkv);
//   static const String audioFile = r'\.(mp3|wav|flac|aac|ogg|wma);
//   static const String documentFile = r'\.(pdf|doc|docx|txt|rtf|odt);
//   static const String spreadsheetFile = r'\.(xls|xlsx|csv|ods);

//   // Banking
//   static const String vietnameseBankAccount = r'^[0-9]{6,19};
//   static const String creditCard = r'^[0-9]{13,19};
//   static const String luhnAlgorithm = r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|3[47][0-9]{13}|3[0-9]{13}|6(?:011|5[0-9]{2})[0-9]{12});

//   // Date Formats
//   static const String vietnameseDate = r'^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4};
//   static const String isoDate = r'^\d{4}-\d{2}-\d{2};
//   static const String isoDateTime = r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d{3})?Z?;

//   // Time Formats
//   static const String time24 = r'^([01]?[0-9]|2[0-3]):[0-5][0-9];
//   static const String time12 = r'^(0?[1-9]|1[0-2]):[0-5][0-9]\s?(AM|PM|am|pm);

//   // Color Codes
//   static const String hexColor = r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3});
//   static const String rgb = r'^rgb\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})\);
//   static const String rgba = r'^rgba\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3}),\s*(0?\.\d+|1(\.0+)?)\);

//   // Vietnamese Address
//   static const String vietnameseAddress = r'^[àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬÈÉẺẼẸÊỀẾỂỄỆÌÍỈĨỊÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴĐa-zA-Z0-9\s,.-/]+;
//   static const String vietnamesePostalCode = r'^[0-9]{5,6};

//   // Special Characters
//   static const String alphanumeric = r'^[a-zA-Z0-9]+;
//   static const String alphanumericWithSpaces = r'^[a-zA-Z0-9\s]+;
//   static const String noSpecialChars = r'^[a-zA-Z0-9\s]+;
//   static const String onlyLetters = r'^[a-zA-Z]+;
//   static const String onlyNumbers = r'^[0-9]+;

//   // Vietnamese License Plate
//   static const String vietnameseLicensePlate = r'^[0-9]{2}[A-Z]{1,2}-[0-9]{4,5}\.[0-9]{2};

//   // Coordinates
//   static const String latitude = r'^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?);
//   static const String longitude = r'^[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?);

//   // IP Addresses
//   static const String ipv4 = r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?);
//   static const String ipv6 = r'^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4};

//   // Vietnamese Tax Code
//   static const String vietnameseTaxCode = r'^[0-9]{10}(-[0-9]{3})?;

//   // Vietnamese Business License
//   static const String vietnameseBusinessLicense = r'^[0-9]{13};

//   // Username formats
//   static const String username = r'^[a-zA-Z0-9_]{3,20};
//   static const String vietnameseUsername = r'^[a-zA-Z0-9_àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđÀÁẢÃẠĂẰẮẲẴẶÂẦẤẨẪẬÈÉẺẼẸÊỀẾỂỄỆÌÍỈĨỊÒÓỎÕỌÔỒỐỔỖỘƠỜỚỞỠỢÙÚỦŨỤƯỪỨỬỮỰỲÝỶỸỴĐ]{3,20};

//   // HTML Tags
//   static const String htmlTags = r'<[^>]*>';
//   static const String stripHtml = r'<(?:"[^"]*"['"]*|'[^']*'['"]*|[^'">])+>';

//   // Vietnamese Currency (VND)
//   static const String vietnameseCurrency = r'^[0-9]{1,3}(\.[0-9]{3})*(\,[0-9]+)?\s?(₫|VND|đồng)?;

//   // Whitespace
//   static const String multipleSpaces = r'\s+';
//   static const String leadingTrailingSpaces = r'^\s+|\s+;

//   // Version Numbers
//   static const String semVer = r'^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?;

//   // MAC Address
//   static const String macAddress = r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2});

//   // GUID/UUID
//   static const String uuid = r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12};

//   /// Create RegExp object from pattern
//   static RegExp createRegExp(String pattern, {bool caseSensitive = true, bool multiLine = false}) {
//     return RegExp(pattern, caseSensitive: caseSensitive, multiLine: multiLine);
//   }

//   /// Validate using pattern
//   static bool validate(String input, String pattern) {
//     return createRegExp(pattern).hasMatch(input);
//   }

//   /// Extract matches from text
//   static List<String> extractMatches(String input, String pattern) {
//     final regex = createRegExp(pattern);
//     return regex.allMatches(input).map((match) => match.group(0)!).toList();
//   }

//   /// Replace pattern in text
//   static String replacePattern(String input, String pattern, String replacement) {
//     return input.replaceAll(createRegExp(pattern), replacement);
//   }

//   /// Check if entire string matches pattern
//   static bool isExactMatch(String input, String pattern) {
//     final regex = createRegExp('^$pattern\);
//     return regex.hasMatch(input);
//   }
// }
