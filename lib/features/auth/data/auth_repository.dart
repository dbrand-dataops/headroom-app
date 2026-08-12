import 'package:dio/dio.dart';

import '../../../core/models/auth_response.dart';
import '../../../core/models/user.dart';
import '../../../core/network/api_call.dart';
import '../../../core/storage/token_storage.dart';

/// Talks to the `/api/auth` endpoints (section 8.1) and persists/clears the
/// session token in secure storage.
class AuthRepository {
  AuthRepository({required Dio dio, required TokenStorage tokenStorage})
    : _dio = dio,
      _tokenStorage = tokenStorage;

  final Dio _dio;
  final TokenStorage _tokenStorage;

  Future<User> register({
    required String email,
    required String password,
    String? displayName,
    String? timezone,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{
      'email': email,
      'password': password,
    };
    final String trimmedDisplayName = displayName?.trim() ?? '';
    if (trimmedDisplayName.isNotEmpty) {
      body['displayName'] = trimmedDisplayName;
    }
    if (timezone != null) {
      body['timezone'] = timezone;
    }
    final Response<dynamic> response = await guardApiCall(
      () => _dio.post<dynamic>('/auth/register', data: body),
    );
    final AuthResponse auth = AuthResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
    await _tokenStorage.writeToken(auth.token);
    return auth.user;
  }

  Future<User> login({required String email, required String password}) async {
    final Response<dynamic> response = await guardApiCall(
      () => _dio.post<dynamic>(
        '/auth/login',
        data: <String, dynamic>{'email': email, 'password': password},
      ),
    );
    final AuthResponse auth = AuthResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
    await _tokenStorage.writeToken(auth.token);
    return auth.user;
  }

  /// Best-effort server-side logout; the local token is always cleared even
  /// if the network call fails (e.g. the session already expired).
  Future<void> logout() async {
    try {
      await _dio.post<dynamic>('/auth/logout');
    } on DioException {
      // Ignored: the local session is cleared regardless below.
    } finally {
      await _tokenStorage.deleteToken();
    }
  }

  Future<User> me() async {
    final Response<dynamic> response = await guardApiCall(
      () => _dio.get<dynamic>('/auth/me'),
    );
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return User.fromJson(data['user'] as Map<String, dynamic>);
  }

  /// Always succeeds from the caller's perspective (the API returns
  /// `{ ok: true }` whether or not the account exists, to prevent
  /// enumeration - section 4.3).
  Future<void> forgotPassword({required String email}) async {
    await guardApiCall(
      () => _dio.post<dynamic>(
        '/auth/forgot-password',
        data: <String, dynamic>{'email': email},
      ),
    );
  }
}
