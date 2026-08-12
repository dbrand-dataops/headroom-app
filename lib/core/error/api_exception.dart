import 'package:dio/dio.dart';

/// A typed exception carrying the server's `{ "error": "..." }` message
/// and HTTP status code, as documented in section 8 of the API reference.
class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.upgrade = false,
  });

  /// Builds an [ApiException] from a failed [DioException], extracting the
  /// `error` field from the JSON body when present and falling back to a
  /// friendly message for network-level failures (timeouts, no connection).
  factory ApiException.fromDioException(DioException exception) {
    final Object? data = exception.response?.data;
    String message = _fallbackMessage(exception);
    bool upgrade = false;

    if (data is Map<String, dynamic>) {
      final Object? error = data['error'];
      if (error is String && error.isNotEmpty) {
        message = error;
      }
      if (data['upgrade'] == true) {
        upgrade = true;
      }
    }

    return ApiException(
      message: message,
      statusCode: exception.response?.statusCode,
      upgrade: upgrade,
    );
  }

  final String message;
  final int? statusCode;
  final bool upgrade;

  static const Set<DioExceptionType> _timeoutTypes = <DioExceptionType>{
    DioExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout,
  };

  static String _fallbackMessage(DioException exception) {
    if (_timeoutTypes.contains(exception.type)) {
      return 'The connection timed out. Please try again.';
    }
    if (exception.type == DioExceptionType.connectionError) {
      return 'Could not connect. Please check your internet connection.';
    }
    if (exception.type == DioExceptionType.badCertificate) {
      return 'A secure connection could not be established.';
    }
    if (exception.type == DioExceptionType.cancel) {
      return 'The request was cancelled.';
    }
    return 'Something went wrong. Please try again.';
  }

  @override
  String toString() => message;
}
