import 'package:dio/dio.dart';

import '../storage/token_storage.dart';
import 'auth_event_bus.dart';

/// Attaches auth headers to every request and reacts to expired sessions.
///
/// - Adds `X-Client: mobile` to every request, per the mobile integration
///   guide (section 9), so the server returns the raw session token instead
///   of only setting a cookie.
/// - Adds `Authorization: Bearer <token>` when a token is stored.
/// - On a 401 response, clears the stored token and notifies [authEventBus]
///   so the app can redirect to login — *except* for `POST /auth/login`
///   itself, where a 401 means "wrong credentials", not "session expired".
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.tokenStorage, required this.authEventBus});

  final TokenStorage tokenStorage;
  final AuthEventBus authEventBus;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['X-Client'] = 'mobile';
    final String? token = await tokenStorage.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isLoginRequest(err.requestOptions)) {
      await tokenStorage.deleteToken();
      authEventBus.notifyUnauthorized();
    }
    handler.next(err);
  }

  bool _isLoginRequest(RequestOptions options) {
    return options.method.toUpperCase() == 'POST' &&
        options.path.replaceAll(RegExp(r'/+$'), '').endsWith('/auth/login');
  }
}
