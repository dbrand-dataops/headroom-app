import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:headroom/core/models/starter_items.dart';
import 'package:headroom/core/network/providers.dart';
import 'package:headroom/core/storage/token_storage.dart';
import 'package:headroom/features/auth/data/auth_repository.dart';
import 'package:headroom/features/auth/state/auth_controller.dart';
import 'package:headroom/features/onboarding/data/onboarding_repository.dart';
import 'package:headroom/features/onboarding/screens/onboarding_screen.dart';
import 'package:headroom/features/onboarding/state/onboarding_controller.dart';
import 'package:mocktail/mocktail.dart';

class _MockOnboardingRepository extends Mock implements OnboardingRepository {}

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late _MockOnboardingRepository onboardingRepository;
  late _MockAuthRepository authRepository;
  late _MockTokenStorage tokenStorage;

  setUp(() {
    onboardingRepository = _MockOnboardingRepository();
    authRepository = _MockAuthRepository();
    tokenStorage = _MockTokenStorage();
    when(() => tokenStorage.readToken()).thenAnswer((_) async => null);
    when(() => onboardingRepository.getStarters()).thenAnswer(
      (_) async => const StarterItems(
        fillers: <StarterItem>[
          StarterItem(label: 'Work deadline', defaultValue: 20),
          StarterItem(label: 'Argument', defaultValue: 15),
        ],
        emptiers: <StarterItem>[
          StarterItem(label: 'Walk', defaultValue: 10),
          StarterItem(label: 'Nap', defaultValue: 25),
        ],
      ),
    );
  });

  Future<void> pumpOnboardingScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          onboardingRepositoryProvider.overrideWithValue(onboardingRepository),
          authRepositoryProvider.overrideWithValue(authRepository),
          tokenStorageProvider.overrideWithValue(tokenStorage),
        ],
        child: const MaterialApp(home: OnboardingScreen()),
      ),
    );
    await tester.pumpAndSettle();
  }

  FilledButton continueButton(WidgetTester tester) =>
      tester.widget<FilledButton>(find.widgetWithText(FilledButton, 'Continue'));

  bool chipSelected(WidgetTester tester, String label) =>
      tester.widget<InputChip>(find.widgetWithText(InputChip, label)).selected;

  testWidgets(
    'items start unselected and the Continue button enables/disables '
    'immediately as chips are tapped',
    (tester) async {
      await pumpOnboardingScreen(tester);

      // Nothing pre-selected, so the button starts disabled.
      expect(chipSelected(tester, 'Work deadline (20)'), isFalse);
      expect(chipSelected(tester, 'Argument (15)'), isFalse);
      expect(chipSelected(tester, 'Walk (10)'), isFalse);
      expect(chipSelected(tester, 'Nap (25)'), isFalse);
      expect(continueButton(tester).onPressed, isNull);

      // Select one filler only - still disabled, no emptier yet.
      await tester.tap(find.widgetWithText(InputChip, 'Work deadline (20)'));
      await tester.pump();
      expect(chipSelected(tester, 'Work deadline (20)'), isTrue);
      expect(continueButton(tester).onPressed, isNull);

      // Select one emptier too - button must enable on this very frame.
      await tester.tap(find.widgetWithText(InputChip, 'Walk (10)'));
      await tester.pump();
      expect(chipSelected(tester, 'Walk (10)'), isTrue);
      expect(continueButton(tester).onPressed, isNotNull);

      // Deselect the only selected filler - button must disable immediately.
      await tester.tap(find.widgetWithText(InputChip, 'Work deadline (20)'));
      await tester.pump();
      expect(chipSelected(tester, 'Work deadline (20)'), isFalse);
      expect(continueButton(tester).onPressed, isNull);

      // Re-select a filler - re-enables immediately.
      await tester.tap(find.widgetWithText(InputChip, 'Argument (15)'));
      await tester.pump();
      expect(continueButton(tester).onPressed, isNotNull);

      // Deselect the only selected emptier - button must disable again.
      await tester.tap(find.widgetWithText(InputChip, 'Walk (10)'));
      await tester.pump();
      expect(continueButton(tester).onPressed, isNull);
    },
  );
}
