import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headroom/core/error/api_exception.dart';
import 'package:headroom/core/network/providers.dart';
import 'package:headroom/core/storage/token_storage.dart';
import 'package:headroom/features/auth/data/auth_repository.dart';
import 'package:headroom/features/auth/screens/login_screen.dart';
import 'package:headroom/features/auth/state/auth_controller.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late _MockAuthRepository authRepository;
  late _MockTokenStorage tokenStorage;

  setUp(() {
    authRepository = _MockAuthRepository();
    tokenStorage = _MockTokenStorage();
    // No stored session, so AuthController settles into `unauthenticated`
    // without making any network calls.
    when(() => tokenStorage.readToken()).thenAnswer((_) async => null);
  });

  Future<void> pumpLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          authRepositoryProvider.overrideWithValue(authRepository),
          tokenStorageProvider.overrideWithValue(tokenStorage),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows validation errors when submitted empty', (tester) async {
    await pumpLoginScreen(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pump();

    expect(find.text('Email is required.'), findsOneWidget);
    expect(find.text('Password is required.'), findsOneWidget);
    verifyNever(() => authRepository.login(email: any(named: 'email'), password: any(named: 'password')));
  });

  testWidgets('shows an error for an invalid email format', (tester) async {
    await pumpLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).first, 'not-an-email');
    await tester.enterText(find.byType(TextFormField).last, 'longenoughpassword');
    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pump();

    expect(find.text('Enter a valid email address.'), findsOneWidget);
  });

  testWidgets('shows an error for a password under 8 characters', (tester) async {
    await pumpLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).first, 'dave@example.com');
    await tester.enterText(find.byType(TextFormField).last, '1234567');
    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pump();

    expect(find.text('Password must be at least 8 characters.'), findsOneWidget);
  });

  testWidgets('submits valid credentials and surfaces the server error message on failure', (
    tester,
  ) async {
    when(
      () => authRepository.login(
        email: 'dave@example.com',
        password: 'wrongpassword',
      ),
    ).thenThrow(
      const ApiException(
        message: 'Invalid email or password.',
        statusCode: 401,
      ),
    );

    await pumpLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).first, 'dave@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'wrongpassword');
    await tester.tap(find.widgetWithText(FilledButton, 'Log in'));
    await tester.pumpAndSettle();

    verify(
      () => authRepository.login(
        email: 'dave@example.com',
        password: 'wrongpassword',
      ),
    ).called(1);
    expect(find.text('Invalid email or password.'), findsOneWidget);
  });
}
