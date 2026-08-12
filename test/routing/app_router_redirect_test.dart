import 'package:flutter_test/flutter_test.dart';
import 'package:headroom/core/models/user.dart';
import 'package:headroom/features/auth/state/auth_state.dart';
import 'package:headroom/routing/app_router.dart';

void main() {
  const User onboardedUser = User(
    id: 1,
    email: 'dave@example.com',
    displayName: 'Dave',
    tier: 'full',
    earlyAdopter: true,
    isAdmin: false,
    timezone: 'Europe/London',
    onboarded: true,
  );

  const User notOnboardedUser = User(
    id: 2,
    email: 'new@example.com',
    tier: 'free',
    earlyAdopter: false,
    isAdmin: false,
    timezone: 'Europe/London',
    onboarded: false,
  );

  group('AuthState.unknown', () {
    const AuthState state = AuthState.unknown();

    test('stays on splash', () {
      expect(redirectForAuthState(state, splashPath), isNull);
    });

    test('redirects any other location to splash', () {
      expect(redirectForAuthState(state, loginPath), splashPath);
      expect(redirectForAuthState(state, homePath), splashPath);
      expect(redirectForAuthState(state, onboardingPath), splashPath);
    });
  });

  group('AuthState.unauthenticated', () {
    const AuthState state = AuthState.unauthenticated();

    test('allows the auth screens through unchanged', () {
      expect(redirectForAuthState(state, loginPath), isNull);
      expect(redirectForAuthState(state, registerPath), isNull);
      expect(redirectForAuthState(state, forgotPasswordPath), isNull);
    });

    test('redirects splash, onboarding and home to login', () {
      expect(redirectForAuthState(state, splashPath), loginPath);
      expect(redirectForAuthState(state, onboardingPath), loginPath);
      expect(redirectForAuthState(state, homePath), loginPath);
    });
  });

  group('AuthState.authenticated, not onboarded', () {
    const AuthState state = AuthState.authenticated(notOnboardedUser);

    test('stays on onboarding', () {
      expect(redirectForAuthState(state, onboardingPath), isNull);
    });

    test('forces every other location to onboarding', () {
      expect(redirectForAuthState(state, homePath), onboardingPath);
      expect(redirectForAuthState(state, loginPath), onboardingPath);
      expect(redirectForAuthState(state, splashPath), onboardingPath);
    });
  });

  group('AuthState.authenticated, onboarded', () {
    const AuthState state = AuthState.authenticated(onboardedUser);

    test('stays on home', () {
      expect(redirectForAuthState(state, homePath), isNull);
    });

    test('sends onboarding, auth screens and splash to home', () {
      expect(redirectForAuthState(state, onboardingPath), homePath);
      expect(redirectForAuthState(state, loginPath), homePath);
      expect(redirectForAuthState(state, splashPath), homePath);
    });
  });
}
