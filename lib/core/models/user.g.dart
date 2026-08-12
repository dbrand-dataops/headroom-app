// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  tier: json['tier'] as String,
  earlyAdopter: json['earlyAdopter'] as bool,
  isAdmin: json['isAdmin'] as bool,
  timezone: json['timezone'] as String,
  onboarded: json['onboarded'] as bool,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'displayName': instance.displayName,
  'tier': instance.tier,
  'earlyAdopter': instance.earlyAdopter,
  'isAdmin': instance.isAdmin,
  'timezone': instance.timezone,
  'onboarded': instance.onboarded,
};
