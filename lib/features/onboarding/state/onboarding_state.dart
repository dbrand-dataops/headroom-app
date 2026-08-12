import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/selectable_item.dart';

part 'onboarding_state.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(true) bool isLoadingStarters,
    String? loadError,
    @Default(<SelectableItem>[]) List<SelectableItem> items,
    @Default(false) bool isSubmitting,
    String? submitError,
  }) = _OnboardingState;
}
