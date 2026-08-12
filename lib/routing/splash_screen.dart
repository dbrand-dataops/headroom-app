import 'package:flutter/material.dart';

/// Shown only while [AuthState.unknown] - i.e. while a stored token is
/// being validated against `GET /auth/me` on app start.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
