import 'package:dio/dio.dart';

import '../config/environment.dart';
import '../storage/token_storage.dart';
import 'auth_event_bus.dart';
import 'auth_interceptor.dart';

Dio buildDioClient({
  required TokenStorage tokenStorage,
  required AuthEventBus authEventBus,
  String baseUrl = Environment.apiBaseUrl,
}) {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );
  dio.interceptors.add(
    AuthInterceptor(tokenStorage: tokenStorage, authEventBus: authEventBus),
  );
  return dio;
}
