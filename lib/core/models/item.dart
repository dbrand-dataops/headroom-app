import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

/// An item as used by the onboarding flow: a label, its category
/// (`filler` or `emptier`), and its default impact value (1-50).
///
/// This is the shape `POST /onboarding/complete` expects in its `items`
/// array (section 8.2). The full items catalogue (`GET/POST /api/items`,
/// section 8.3) returns raw snake_case rows with additional fields
/// (`id`, `sortOrder`, `active`) and belongs to the Phase 2 items feature.
@freezed
abstract class Item with _$Item {
  const factory Item({
    required String label,
    required ItemType type,
    required int defaultValue,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

enum ItemType {
  @JsonValue('filler')
  filler,
  @JsonValue('emptier')
  emptier,
}
