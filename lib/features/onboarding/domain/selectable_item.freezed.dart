// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selectable_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectableItem {

 String get label; ItemType get type; int get defaultValue; bool get selected; bool get isCustom;
/// Create a copy of SelectableItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectableItemCopyWith<SelectableItem> get copyWith => _$SelectableItemCopyWithImpl<SelectableItem>(this as SelectableItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectableItem&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom));
}


@override
int get hashCode => Object.hash(runtimeType,label,type,defaultValue,selected,isCustom);

@override
String toString() {
  return 'SelectableItem(label: $label, type: $type, defaultValue: $defaultValue, selected: $selected, isCustom: $isCustom)';
}


}

/// @nodoc
abstract mixin class $SelectableItemCopyWith<$Res>  {
  factory $SelectableItemCopyWith(SelectableItem value, $Res Function(SelectableItem) _then) = _$SelectableItemCopyWithImpl;
@useResult
$Res call({
 String label, ItemType type, int defaultValue, bool selected, bool isCustom
});




}
/// @nodoc
class _$SelectableItemCopyWithImpl<$Res>
    implements $SelectableItemCopyWith<$Res> {
  _$SelectableItemCopyWithImpl(this._self, this._then);

  final SelectableItem _self;
  final $Res Function(SelectableItem) _then;

/// Create a copy of SelectableItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? type = null,Object? defaultValue = null,Object? selected = null,Object? isCustom = null,}) {
  return _then(SelectableItem(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ItemType,defaultValue: null == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as int,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as bool,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectableItem].
extension SelectableItemPatterns on SelectableItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectableItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectableItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectableItem value)  $default,){
final _that = this;
switch (_that) {
case _SelectableItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectableItem value)?  $default,){
final _that = this;
switch (_that) {
case _SelectableItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  ItemType type,  int defaultValue,  bool selected,  bool isCustom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectableItem() when $default != null:
return $default(_that.label,_that.type,_that.defaultValue,_that.selected,_that.isCustom);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  ItemType type,  int defaultValue,  bool selected,  bool isCustom)  $default,) {final _that = this;
switch (_that) {
case _SelectableItem():
return $default(_that.label,_that.type,_that.defaultValue,_that.selected,_that.isCustom);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  ItemType type,  int defaultValue,  bool selected,  bool isCustom)?  $default,) {final _that = this;
switch (_that) {
case _SelectableItem() when $default != null:
return $default(_that.label,_that.type,_that.defaultValue,_that.selected,_that.isCustom);case _:
  return null;

}
}

}

/// @nodoc


class _SelectableItem implements SelectableItem {
  const _SelectableItem({required this.label, required this.type, required this.defaultValue, required this.selected, this.isCustom = false});
  

@override final  String label;
@override final  ItemType type;
@override final  int defaultValue;
@override final  bool selected;
@override@JsonKey() final  bool isCustom;

/// Create a copy of SelectableItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectableItemCopyWith<_SelectableItem> get copyWith => __$SelectableItemCopyWithImpl<_SelectableItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectableItem&&(identical(other.label, label) || other.label == label)&&(identical(other.type, type) || other.type == type)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom));
}


@override
int get hashCode => Object.hash(runtimeType,label,type,defaultValue,selected,isCustom);

@override
String toString() {
  return 'SelectableItem(label: $label, type: $type, defaultValue: $defaultValue, selected: $selected, isCustom: $isCustom)';
}


}

/// @nodoc
abstract mixin class _$SelectableItemCopyWith<$Res> implements $SelectableItemCopyWith<$Res> {
  factory _$SelectableItemCopyWith(_SelectableItem value, $Res Function(_SelectableItem) _then) = __$SelectableItemCopyWithImpl;
@override @useResult
$Res call({
 String label, ItemType type, int defaultValue, bool selected, bool isCustom
});




}
/// @nodoc
class __$SelectableItemCopyWithImpl<$Res>
    implements _$SelectableItemCopyWith<$Res> {
  __$SelectableItemCopyWithImpl(this._self, this._then);

  final _SelectableItem _self;
  final $Res Function(_SelectableItem) _then;

/// Create a copy of SelectableItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? type = null,Object? defaultValue = null,Object? selected = null,Object? isCustom = null,}) {
  return _then(_SelectableItem(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ItemType,defaultValue: null == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as int,selected: null == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as bool,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
