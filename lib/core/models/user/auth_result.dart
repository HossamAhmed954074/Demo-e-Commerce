/// Custom result type for authentication operations
class AuthResult<T> {
  final bool isSuccess;
  final T? data;
  final String? error;
  final AuthErrorType? errorType;

  const AuthResult._({
    required this.isSuccess,
    this.data,
    this.error,
    this.errorType,
  });

  /// Success result
  factory AuthResult.success(T data) {
    return AuthResult._(isSuccess: true, data: data);
  }

  /// Error result
  factory AuthResult.error(String error, [AuthErrorType? errorType]) {
    return AuthResult._(isSuccess: false, error: error, errorType: errorType);
  }
}

/// Types of authentication errors
enum AuthErrorType {
  invalidEmail,
  weakPassword,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  networkError,
  unknown,
}
