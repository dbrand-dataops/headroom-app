import 'package:freezed_annotation/freezed_annotation.dart';

part 'starter_items.freezed.dart';
part 'starter_items.g.dart';

/// A single suggested starter item as returned by `GET /onboarding/starters`
/// (section 8.2). Category (filler/emptier) is implied by which list of
/// [StarterItems] it appears in, so it has no `type` field of its own.
@freezed
abstract class StarterItem with _$StarterItem {
  const factory StarterItem({required String label, required int defaultValue}) =
      _StarterItem;

  factory StarterItem.fromJson(Map<String, dynamic> json) =>
      _$StarterItemFromJson(json);
}

/// The response body of `GET /onboarding/starters`.
@freezed
abstract class StarterItems with _$StarterItems {
  const factory StarterItems({
    required List<StarterItem> fillers,
    required List<StarterItem> emptiers,
  }) = _StarterItems;

  factory StarterItems.fromJson(Map<String, dynamic> json) =>
      _$StarterItemsFromJson(json);
}
