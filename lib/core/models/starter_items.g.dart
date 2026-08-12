// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starter_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StarterItem _$StarterItemFromJson(Map<String, dynamic> json) => _StarterItem(
  label: json['label'] as String,
  defaultValue: (json['defaultValue'] as num).toInt(),
);

Map<String, dynamic> _$StarterItemToJson(_StarterItem instance) =>
    <String, dynamic>{
      'label': instance.label,
      'defaultValue': instance.defaultValue,
    };

_StarterItems _$StarterItemsFromJson(Map<String, dynamic> json) =>
    _StarterItems(
      fillers: (json['fillers'] as List<dynamic>)
          .map((e) => StarterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      emptiers: (json['emptiers'] as List<dynamic>)
          .map((e) => StarterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StarterItemsToJson(_StarterItems instance) =>
    <String, dynamic>{
      'fillers': instance.fillers,
      'emptiers': instance.emptiers,
    };
