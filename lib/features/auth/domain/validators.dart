/// Client-side mirrors of the backend's validation rules (section 4.2,
/// section 8.1), so users get instant feedback instead of a round trip.
class AuthValidators {
  const AuthValidators._();

  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? value) {
    final String trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Email is required.';
    }
    if (!_emailPattern.hasMatch(trimmed)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  /// The backend enforces a minimum of 8 characters with no composition
  /// rules (section 4.2) - matched exactly here, no extra client-side rules.
  static String? password(String? value) {
    final String input = value ?? '';
    if (input.isEmpty) {
      return 'Password is required.';
    }
    if (input.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    return null;
  }
}
