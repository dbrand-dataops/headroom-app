import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/user.dart';

part 'auth_state.freezed.dart';

/// The three states the rest of the app (router included) reacts to:
/// - [AuthState.unknown]: startup, still validating a stored token.
/// - [AuthState.unauthenticated]: no valid session; only auth screens.
/// - [AuthState.authenticated]: a valid session with the current [User].
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.unknown() = AuthUnknown;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.authenticated(User user) = AuthAuthenticated;
}
