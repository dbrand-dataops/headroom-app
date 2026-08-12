import 'package:flutter/material.dart';

/// Headroom's Material 3 theme. Kept intentionally simple for Phase 1;
/// the bucket-level colour language (calm/settled/building/elevated/
/// high/critical) belongs to the Phase 2 bucket UI.
class AppTheme {
  const AppTheme._();

  static const Color _seed = Color(0xFF3E6D9C);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: _seed),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
