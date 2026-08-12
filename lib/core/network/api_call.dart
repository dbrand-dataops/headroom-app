import 'package:dio/dio.dart';

import '../error/api_exception.dart';

/// Runs a Dio call and converts any [DioException] into a typed
/// [ApiException] carrying the server's `error` message and status code.
Future<T> guardApiCall<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (e) {
    throw ApiException.fromDioException(e);
  }
}
