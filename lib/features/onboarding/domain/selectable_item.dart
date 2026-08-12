import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/item.dart';

part 'selectable_item.freezed.dart';

/// A starter suggestion or custom item as presented on the onboarding
/// screen: a chip the user can select/deselect, with custom ones also
/// removable.
@freezed
abstract class SelectableItem with _$SelectableItem {
  const factory SelectableItem({
    required String label,
    required ItemType type,
    required int defaultValue,
    required bool selected,
    @Default(false) bool isCustom,
  }) = _SelectableItem;
}

extension SelectableItemToItem on SelectableItem {
  Item toItem() => Item(label: label, type: type, defaultValue: defaultValue);
}
