import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/state/auth_controller.dart';
import '../features/auth/state/auth_state.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import 'splash_screen.dart';

const String splashPath = '/splash';
const String loginPath = '/login';
const String registerPath = '/register';
const String forgotPasswordPath = '/forgot-password';
const String onboardingPath = '/onboarding';
const String homePath = '/home';

final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
  final _AuthRefreshNotifier refreshNotifier = _AuthRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: splashPath,
    refreshListenable: refreshNotifier,
    redirect: (context, state) =>
        redirectForAuthState(ref.read(authControllerProvider), state.matchedLocation),
    routes: <RouteBase>[
      GoRoute(
        path: splashPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: registerPath,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: forgotPasswordPath,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: onboardingPath,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: homePath,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});

/// Pure redirect decision, split out from [routerProvider] so it can be
/// unit-tested without spinning up a GoRouter/widget tree.
///
/// - [AuthState.unknown]: still validating a stored token -> splash only.
/// - [AuthState.unauthenticated]: only the auth screens are reachable.
/// - [AuthState.authenticated] and not onboarded: forced to /onboarding.
/// - [AuthState.authenticated] and onboarded: forced to /home.
@visibleForTesting
String? redirectForAuthState(AuthState authState, String location) {
  const Set<String> authRoutes = <String>{
    loginPath,
    registerPath,
    forgotPasswordPath,
  };

  return switch (authState) {
    AuthUnknown() => location == splashPath ? null : splashPath,
    AuthUnauthenticated() => authRoutes.contains(location) ? null : loginPath,
    AuthAuthenticated(:final user) => user.onboarded
        ? (location == homePath ? null : homePath)
        : (location == onboardingPath ? null : onboardingPath),
  };
}

class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    ref.listen<AuthState>(
      authControllerProvider,
      (previous, next) => notifyListeners(),
      fireImmediately: false,
    );
  }
}
