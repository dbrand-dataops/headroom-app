import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/api_exception.dart';
import '../../../core/network/auth_event_bus.dart';
import '../../../core/network/providers.dart';
import '../../../core/storage/token_storage.dart';
import '../data/auth_repository.dart';
import 'auth_state.dart';

final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>((ref) {
      return AuthRepository(
        dio: ref.watch(dioProvider),
        tokenStorage: ref.watch(tokenStorageProvider),
      );
    });

final StateNotifierProvider<AuthController, AuthState> authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
      return AuthController(
        repository: ref.watch(authRepositoryProvider),
        tokenStorage: ref.watch(tokenStorageProvider),
        authEventBus: ref.watch(authEventBusProvider),
      );
    });

/// Owns the app-wide auth state. On construction, if a token is already
/// stored it is validated against `GET /auth/me`; an invalid/expired token
/// falls back to unauthenticated rather than throwing.
class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required AuthRepository repository,
    required TokenStorage tokenStorage,
    required AuthEventBus authEventBus,
  }) : _repository = repository,
       _tokenStorage = tokenStorage,
       super(const AuthState.unknown()) {
    _unauthorizedSubscription = authEventBus.onUnauthorized.listen((_) {
      state = const AuthState.unauthenticated();
    });
    unawaited(_restoreSession());
  }

  final AuthRepository _repository;
  final TokenStorage _tokenStorage;
  late final StreamSubscription<void> _unauthorizedSubscription;

  Future<void> _restoreSession() async {
    final String? token = await _tokenStorage.readToken();
    if (token == null || token.isEmpty) {
      state = const AuthState.unauthenticated();
      return;
    }
    try {
      final user = await _repository.me();
      state = AuthState.authenticated(user);
    } on ApiException {
      state = const AuthState.unauthenticated();
    }
  }

  Future<void> register({
    required String email,
    required String password,
    String? displayName,
    String? timezone,
  }) async {
    final user = await _repository.register(
      email: email,
      password: password,
      displayName: displayName,
      timezone: timezone,
    );
    state = AuthState.authenticated(user);
  }

  Future<void> login({required String email, required String password}) async {
    final user = await _repository.login(email: email, password: password);
    state = AuthState.authenticated(user);
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState.unauthenticated();
  }

  /// Flips the cached user's `onboarded` flag once onboarding completes, so
  /// the router can move straight to /home without an extra /auth/me call.
  void markOnboarded() {
    final AuthState current = state;
    if (current is AuthAuthenticated) {
      state = AuthState.authenticated(current.user.copyWith(onboarded: true));
    }
  }

  @override
  void dispose() {
    unawaited(_unauthorizedSubscription.cancel());
    super.dispose();
  }
}
