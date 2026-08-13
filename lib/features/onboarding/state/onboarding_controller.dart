import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/error/api_exception.dart';
import '../../../core/models/item.dart';
import '../../../core/models/starter_items.dart';
import '../../../core/network/providers.dart';
import '../../auth/state/auth_controller.dart';
import '../data/onboarding_repository.dart';
import '../domain/selectable_item.dart';
import 'onboarding_state.dart';

final Provider<OnboardingRepository> onboardingRepositoryProvider =
    Provider<OnboardingRepository>((ref) {
      return OnboardingRepository(dio: ref.watch(dioProvider));
    });

final StateNotifierProvider<OnboardingController, OnboardingState>
onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
      return OnboardingController(
        repository: ref.watch(onboardingRepositoryProvider),
        authController: ref.watch(authControllerProvider.notifier),
      );
    });

/// Drives the onboarding screen: loads starter suggestions, tracks which
/// items (suggested and custom) are selected, and submits the final list.
class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController({
    required OnboardingRepository repository,
    required AuthController authController,
  }) : _repository = repository,
       _authController = authController,
       super(const OnboardingState()) {
    unawaited(_loadStarters());
  }

  final OnboardingRepository _repository;
  final AuthController _authController;

  Future<void> _loadStarters() async {
    state = state.copyWith(isLoadingStarters: true, loadError: null);
    try {
      final StarterItems starters = await _repository.getStarters();
      final List<SelectableItem> items = <SelectableItem>[
        for (final starter in starters.fillers)
          SelectableItem(
            label: starter.label,
            type: ItemType.filler,
            defaultValue: starter.defaultValue,
            selected: false,
          ),
        for (final starter in starters.emptiers)
          SelectableItem(
            label: starter.label,
            type: ItemType.emptier,
            defaultValue: starter.defaultValue,
            selected: false,
          ),
      ];
      state = state.copyWith(isLoadingStarters: false, items: items);
    } on ApiException catch (e) {
      state = state.copyWith(isLoadingStarters: false, loadError: e.message);
    }
  }

  Future<void> retryLoadStarters() => _loadStarters();

  void toggleSelected(int index) {
    final List<SelectableItem> items = <SelectableItem>[...state.items];
    items[index] = items[index].copyWith(selected: !items[index].selected);
    state = state.copyWith(items: items);
  }

  void addCustomItem({
    required String label,
    required ItemType type,
    required int value,
  }) {
    state = state.copyWith(
      items: <SelectableItem>[
        ...state.items,
        SelectableItem(
          label: label,
          type: type,
          defaultValue: value,
          selected: true,
          isCustom: true,
        ),
      ],
    );
  }

  void removeCustomItem(int index) {
    final List<SelectableItem> items = <SelectableItem>[...state.items]
      ..removeAt(index);
    state = state.copyWith(items: items);
  }

  bool get canSubmit {
    if (state.isSubmitting || state.isLoadingStarters) {
      return false;
    }
    final Iterable<SelectableItem> selected = state.items.where(
      (SelectableItem i) => i.selected,
    );
    final bool hasFiller = selected.any(
      (SelectableItem i) => i.type == ItemType.filler,
    );
    final bool hasEmptier = selected.any(
      (SelectableItem i) => i.type == ItemType.emptier,
    );
    return hasFiller && hasEmptier;
  }

  Future<bool> submit() async {
    if (!canSubmit) {
      return false;
    }
    state = state.copyWith(isSubmitting: true, submitError: null);
    final List<Item> selectedItems = state.items
        .where((SelectableItem i) => i.selected)
        .map((SelectableItem i) => i.toItem())
        .toList();
    try {
      await _repository.complete(selectedItems);
      _authController.markOnboarded();
      state = state.copyWith(isSubmitting: false);
      return true;
    } on ApiException catch (e) {
      // The API returns 400 both for validation failures and for the
      // one-time-only "already onboarded" case, with no separate status
      // code (section 8.2). Client-side checks already prevent invalid
      // submissions, so a 400 whose message mentions "onboard" is treated
      // as the account having already been onboarded elsewhere, and the
      // flow proceeds to Home instead of showing a confusing error.
      final bool alreadyOnboarded =
          e.statusCode == 400 && e.message.toLowerCase().contains('onboard');
      if (alreadyOnboarded) {
        _authController.markOnboarded();
        state = state.copyWith(isSubmitting: false);
        return true;
      }
      state = state.copyWith(isSubmitting: false, submitError: e.message);
      return false;
    }
  }
}
