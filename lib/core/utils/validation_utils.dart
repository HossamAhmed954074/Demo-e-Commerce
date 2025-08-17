/// Utility class for input validation
class ValidationUtils {
  // Email validation regex
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Validate email format
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    return _emailRegex.hasMatch(email.trim());
  }

  /// Validate password strength
  static bool isValidPassword(String password) {
    if (password.isEmpty || password.length < 6) return false;
    return true;
  }

  /// Get password strength requirements message
  static String getPasswordRequirements() {
    return 'Password must be at least 6 characters long';
  }

  /// Validate display name
  static bool isValidDisplayName(String? displayName) {
    if (displayName == null || displayName.trim().isEmpty) return false;
    return displayName.trim().length >= 2;
  }

  /// Sanitize input string
  static String sanitizeInput(String input) {
    return input.trim();
  }
}
