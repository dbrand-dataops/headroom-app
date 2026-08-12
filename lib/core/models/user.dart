import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Mirrors the `user` object returned by `/auth/register`, `/auth/login`
/// and `/auth/me` (section 8.1). Field names match the API's camelCase JSON
/// exactly.
@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String email,
    String? displayName,
    required String tier,
    required bool earlyAdopter,
    required bool isAdmin,
    required String timezone,
    required bool onboarded,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
