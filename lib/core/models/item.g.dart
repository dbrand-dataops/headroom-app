// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Item _$ItemFromJson(Map<String, dynamic> json) => _Item(
  label: json['label'] as String,
  type: $enumDecode(_$ItemTypeEnumMap, json['type']),
  defaultValue: (json['defaultValue'] as num).toInt(),
);

Map<String, dynamic> _$ItemToJson(_Item instance) => <String, dynamic>{
  'label': instance.label,
  'type': _$ItemTypeEnumMap[instance.type]!,
  'defaultValue': instance.defaultValue,
};

const _$ItemTypeEnumMap = {
  ItemType.filler: 'filler',
  ItemType.emptier: 'emptier',
};
