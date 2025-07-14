/// Text formatter utilities for Vietnamese content
class TextFormatter {
  TextFormatter._();

  // Vietnamese tone marks
  static const Map<String, String> _vietnameseToneMap = {
    'à': 'a',
    'á': 'a',
    'ả': 'a',
    'ã': 'a',
    'ạ': 'a',
    'ằ': 'a',
    'ắ': 'a',
    'ẳ': 'a',
    'ẵ': 'a',
    'ặ': 'a',
    'ầ': 'a',
    'ấ': 'a',
    'ẩ': 'a',
    'ẫ': 'a',
    'ậ': 'a',
    'è': 'e',
    'é': 'e',
    'ẻ': 'e',
    'ẽ': 'e',
    'ẹ': 'e',
    'ề': 'e',
    'ế': 'e',
    'ể': 'e',
    'ễ': 'e',
    'ệ': 'e',
    'ì': 'i',
    'í': 'i',
    'ỉ': 'i',
    'ĩ': 'i',
    'ị': 'i',
    'ò': 'o',
    'ó': 'o',
    'ỏ': 'o',
    'õ': 'o',
    'ọ': 'o',
    'ồ': 'o',
    'ố': 'o',
    'ổ': 'o',
    'ỗ': 'o',
    'ộ': 'o',
    'ờ': 'o',
    'ớ': 'o',
    'ở': 'o',
    'ỡ': 'o',
    'ợ': 'o',
    'ù': 'u',
    'ú': 'u',
    'ủ': 'u',
    'ũ': 'u',
    'ụ': 'u',
    'ừ': 'u',
    'ứ': 'u',
    'ử': 'u',
    'ữ': 'u',
    'ự': 'u',
    'ỳ': 'y',
    'ý': 'y',
    'ỷ': 'y',
    'ỹ': 'y',
    'ỵ': 'y',
    'đ': 'd',
    'À': 'A',
    'Á': 'A',
    'Ả': 'A',
    'Ã': 'A',
    'Ạ': 'A',
    'Ằ': 'A',
    'Ắ': 'A',
    'Ẳ': 'A',
    'Ẵ': 'A',
    'Ặ': 'A',
    'Ầ': 'A',
    'Ấ': 'A',
    'Ẩ': 'A',
    'Ẫ': 'A',
    'Ậ': 'A',
    'È': 'E',
    'É': 'E',
    'Ẻ': 'E',
    'Ẽ': 'E',
    'Ẹ': 'E',
    'Ề': 'E',
    'Ế': 'E',
    'Ể': 'E',
    'Ễ': 'E',
    'Ệ': 'E',
    'Ì': 'I',
    'Í': 'I',
    'Ỉ': 'I',
    'Ĩ': 'I',
    'Ị': 'I',
    'Ò': 'O',
    'Ó': 'O',
    'Ỏ': 'O',
    'Õ': 'O',
    'Ọ': 'O',
    'Ồ': 'O',
    'Ố': 'O',
    'Ổ': 'O',
    'Ỗ': 'O',
    'Ộ': 'O',
    'Ờ': 'O',
    'Ớ': 'O',
    'Ở': 'O',
    'Ỡ': 'O',
    'Ợ': 'O',
    'Ù': 'U',
    'Ú': 'U',
    'Ủ': 'U',
    'Ũ': 'U',
    'Ụ': 'U',
    'Ừ': 'U',
    'Ứ': 'U',
    'Ử': 'U',
    'Ữ': 'U',
    'Ự': 'U',
    'Ỳ': 'Y',
    'Ý': 'Y',
    'Ỷ': 'Y',
    'Ỹ': 'Y',
    'Ỵ': 'Y',
    'Đ': 'D',
  };

  /// Remove Vietnamese tone marks from text
  static String removeVietnameseTones(String text) {
    String result = text;
    _vietnameseToneMap.forEach((accented, normal) {
      result = result.replaceAll(accented, normal);
    });
    return result;
  }

  /// Normalize Vietnamese text for search
  static String normalizeForSearch(String text) {
    return removeVietnameseTones(text.toLowerCase().trim());
  }

  /// Capitalize first letter of each word
  static String toTitleCase(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Capitalize first letter of sentence
  static String toSentenceCase(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Convert to snake_case
  static String toSnakeCase(String text) {
    return removeVietnameseTones(text)
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .toLowerCase();
  }

  /// Convert to kebab-case
  static String toKebabCase(String text) {
    return removeVietnameseTones(text)
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .toLowerCase();
  }

  /// Convert to camelCase
  static String toCamelCase(String text) {
    final words = removeVietnameseTones(text)
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(RegExp(r'\s+'));

    if (words.isEmpty) return '';

    String result = words.first.toLowerCase();
    for (int i = 1; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        result +=
            words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }
    return result;
  }

  /// Convert to PascalCase
  static String toPascalCase(String text) {
    final words = removeVietnameseTones(text)
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(RegExp(r'\s+'));

    return words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join('');
  }

  /// Truncate text with ellipsis
  static String truncate(String text, int length, {String ellipsis = '...'}) {
    if (text.length <= length) return text;
    return text.substring(0, length) + ellipsis;
  }

  /// Truncate by words
  static String truncateWords(String text, int wordCount,
      {String ellipsis = '...'}) {
    final words = text.split(' ');
    if (words.length <= wordCount) return text;
    return words.take(wordCount).join(' ') + ellipsis;
  }

  /// Extract initials from name
  static String getInitials(String name) {
    return name
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join('');
  }

  /// Format Vietnamese name properly
  static String formatVietnameseName(String name) {
    return name
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => toSentenceCase(word))
        .join(' ');
  }

  /// Clean and normalize whitespace
  static String cleanWhitespace(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Remove special characters but keep Vietnamese
  static String removeSpecialChars(String text) {
    return text.replaceAll(
        RegExp(
            r'[^\w\sàáảãạằắẳẵặầấẩẫậèéẻẽẹềếểễệìíỉĩịòóỏõọồốổỗộờớởỡợùúủũụừứửữựỳýỷỹỵđ]',
            caseSensitive: false),
        '');
  }

  /// Check if text contains Vietnamese characters
  static bool containsVietnamese(String text) {
    return RegExp(
            r'[àáảãạằắẳẵặầấẩẫậèéẻẽẹềếểễệìíỉĩịòóỏõọồốổỗộờớởỡợùúủũụừứửữựỳýỷỹỵđ]',
            caseSensitive: false)
        .hasMatch(text);
  }

  /// Count words in text
  static int countWords(String text) {
    return text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
  }

  /// Count characters (excluding spaces)
  static int countCharacters(String text) {
    return text.replaceAll(' ', '').length;
  }

  /// Extract email addresses from text
  static List<String> extractEmails(String text) {
    final emailRegex =
        RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
    return emailRegex.allMatches(text).map((match) => match.group(0)!).toList();
  }

  /// Extract phone numbers from text
  static List<String> extractPhoneNumbers(String text) {
    final phoneRegex = RegExp(r'(\+84|0)[0-9]{8,9}');
    return phoneRegex.allMatches(text).map((match) => match.group(0)!).toList();
  }

  /// Highlight search term in text
  static String highlightSearch(String text, String searchTerm) {
    if (searchTerm.isEmpty) return text;

    final normalizedText = normalizeForSearch(text);
    final normalizedSearch = normalizeForSearch(searchTerm);

    if (!normalizedText.contains(normalizedSearch)) return text;

    final regex = RegExp(RegExp.escape(searchTerm), caseSensitive: false);
    return text.replaceAllMapped(
        regex, (match) => '<mark>${match.group(0)}</mark>');
  }

  /// Generate slug from text
  static String generateSlug(String text) {
    return removeVietnameseTones(text)
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  /// Wrap text to specified width
  static String wrapText(String text, int width) {
    if (text.length <= width) return text;

    final words = text.split(' ');
    final lines = <String>[];
    String currentLine = '';

    for (final word in words) {
      if (('$currentLine $word').length <= width) {
        currentLine = currentLine.isEmpty ? word : '$currentLine $word';
      } else {
        if (currentLine.isNotEmpty) {
          lines.add(currentLine);
          currentLine = word;
        } else {
          lines.add(word);
        }
      }
    }

    if (currentLine.isNotEmpty) {
      lines.add(currentLine);
    }

    return lines.join('\n');
  }

  /// Check if text is valid Vietnamese CCCD/CMND
  static bool isValidVietnameseId(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^\d]'), '');
    return cleaned.length == 9 || cleaned.length == 12;
  }

  /// Check if text is valid Vietnamese phone
  static bool isValidVietnamesePhone(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^\d+]'), '');
    return RegExp(r'^(\+84|0)[0-9]{8,9}$').hasMatch(cleaned);
  }

  /// Escape HTML characters
  static String escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');
  }

  /// Unescape HTML characters
  static String unescapeHtml(String text) {
    return text
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#x27;', "'");
  }

  /// Calculate reading time (average 200 words per minute for Vietnamese)
  static String calculateReadingTime(String text) {
    final wordCount = countWords(text);
    final minutes = (wordCount / 200).ceil();
    return '$minutes phút đọc';
  }

  /// Format text as quote
  static String formatAsQuote(String text, {String? author}) {
    final quote = '"$text"';
    return author != null ? '$quote - $author' : quote;
  }

  /// Convert line breaks to HTML
  static String nl2br(String text) {
    return text.replaceAll('\n', '<br>');
  }

  /// Strip HTML tags
  static String stripHtml(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
