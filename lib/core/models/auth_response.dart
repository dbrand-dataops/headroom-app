import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

/// The response body of `POST /auth/register` and `POST /auth/login`.
///
/// `token` is only present because the app always sends `X-Client: mobile`
/// (section 4.1 / 8.1), which makes the server return the raw session token
/// in the body instead of relying solely on a cookie.
@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({required User user, required String token}) =
      _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}
