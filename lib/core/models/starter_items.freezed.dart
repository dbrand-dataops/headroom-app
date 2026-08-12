// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'starter_items.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StarterItem {

 String get label; int get defaultValue;
/// Create a copy of StarterItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StarterItemCopyWith<StarterItem> get copyWith => _$StarterItemCopyWithImpl<StarterItem>(this as StarterItem, _$identity);

  /// Serializes this StarterItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StarterItem&&(identical(other.label, label) || other.label == label)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,defaultValue);

@override
String toString() {
  return 'StarterItem(label: $label, defaultValue: $defaultValue)';
}


}

/// @nodoc
abstract mixin class $StarterItemCopyWith<$Res>  {
  factory $StarterItemCopyWith(StarterItem value, $Res Function(StarterItem) _then) = _$StarterItemCopyWithImpl;
@useResult
$Res call({
 String label, int defaultValue
});




}
/// @nodoc
class _$StarterItemCopyWithImpl<$Res>
    implements $StarterItemCopyWith<$Res> {
  _$StarterItemCopyWithImpl(this._self, this._then);

  final StarterItem _self;
  final $Res Function(StarterItem) _then;

/// Create a copy of StarterItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? defaultValue = null,}) {
  return _then(StarterItem(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,defaultValue: null == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StarterItem].
extension StarterItemPatterns on StarterItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StarterItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StarterItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StarterItem value)  $default,){
final _that = this;
switch (_that) {
case _StarterItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StarterItem value)?  $default,){
final _that = this;
switch (_that) {
case _StarterItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int defaultValue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StarterItem() when $default != null:
return $default(_that.label,_that.defaultValue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int defaultValue)  $default,) {final _that = this;
switch (_that) {
case _StarterItem():
return $default(_that.label,_that.defaultValue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int defaultValue)?  $default,) {final _that = this;
switch (_that) {
case _StarterItem() when $default != null:
return $default(_that.label,_that.defaultValue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StarterItem implements StarterItem {
  const _StarterItem({required this.label, required this.defaultValue});
  factory _StarterItem.fromJson(Map<String, dynamic> json) => _$StarterItemFromJson(json);

@override final  String label;
@override final  int defaultValue;

/// Create a copy of StarterItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StarterItemCopyWith<_StarterItem> get copyWith => __$StarterItemCopyWithImpl<_StarterItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StarterItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StarterItem&&(identical(other.label, label) || other.label == label)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,defaultValue);

@override
String toString() {
  return 'StarterItem(label: $label, defaultValue: $defaultValue)';
}


}

/// @nodoc
abstract mixin class _$StarterItemCopyWith<$Res> implements $StarterItemCopyWith<$Res> {
  factory _$StarterItemCopyWith(_StarterItem value, $Res Function(_StarterItem) _then) = __$StarterItemCopyWithImpl;
@override @useResult
$Res call({
 String label, int defaultValue
});




}
/// @nodoc
class __$StarterItemCopyWithImpl<$Res>
    implements _$StarterItemCopyWith<$Res> {
  __$StarterItemCopyWithImpl(this._self, this._then);

  final _StarterItem _self;
  final $Res Function(_StarterItem) _then;

/// Create a copy of StarterItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? defaultValue = null,}) {
  return _then(_StarterItem(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,defaultValue: null == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StarterItems {

 List<StarterItem> get fillers; List<StarterItem> get emptiers;
/// Create a copy of StarterItems
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StarterItemsCopyWith<StarterItems> get copyWith => _$StarterItemsCopyWithImpl<StarterItems>(this as StarterItems, _$identity);

  /// Serializes this StarterItems to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StarterItems&&const DeepCollectionEquality().equals(other.fillers, fillers)&&const DeepCollectionEquality().equals(other.emptiers, emptiers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fillers),const DeepCollectionEquality().hash(emptiers));

@override
String toString() {
  return 'StarterItems(fillers: $fillers, emptiers: $emptiers)';
}


}

/// @nodoc
abstract mixin class $StarterItemsCopyWith<$Res>  {
  factory $StarterItemsCopyWith(StarterItems value, $Res Function(StarterItems) _then) = _$StarterItemsCopyWithImpl;
@useResult
$Res call({
 List<StarterItem> fillers, List<StarterItem> emptiers
});




}
/// @nodoc
class _$StarterItemsCopyWithImpl<$Res>
    implements $StarterItemsCopyWith<$Res> {
  _$StarterItemsCopyWithImpl(this._self, this._then);

  final StarterItems _self;
  final $Res Function(StarterItems) _then;

/// Create a copy of StarterItems
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fillers = null,Object? emptiers = null,}) {
  return _then(StarterItems(
fillers: null == fillers ? _self.fillers : fillers // ignore: cast_nullable_to_non_nullable
as List<StarterItem>,emptiers: null == emptiers ? _self.emptiers : emptiers // ignore: cast_nullable_to_non_nullable
as List<StarterItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [StarterItems].
extension StarterItemsPatterns on StarterItems {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StarterItems value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StarterItems() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StarterItems value)  $default,){
final _that = this;
switch (_that) {
case _StarterItems():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StarterItems value)?  $default,){
final _that = this;
switch (_that) {
case _StarterItems() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StarterItem> fillers,  List<StarterItem> emptiers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StarterItems() when $default != null:
return $default(_that.fillers,_that.emptiers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StarterItem> fillers,  List<StarterItem> emptiers)  $default,) {final _that = this;
switch (_that) {
case _StarterItems():
return $default(_that.fillers,_that.emptiers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StarterItem> fillers,  List<StarterItem> emptiers)?  $default,) {final _that = this;
switch (_that) {
case _StarterItems() when $default != null:
return $default(_that.fillers,_that.emptiers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StarterItems implements StarterItems {
  const _StarterItems({required  List<StarterItem> fillers, required  List<StarterItem> emptiers}): _fillers = fillers,_emptiers = emptiers;
  factory _StarterItems.fromJson(Map<String, dynamic> json) => _$StarterItemsFromJson(json);

 final  List<StarterItem> _fillers;
@override List<StarterItem> get fillers {
  if (_fillers is EqualUnmodifiableListView) return _fillers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fillers);
}

 final  List<StarterItem> _emptiers;
@override List<StarterItem> get emptiers {
  if (_emptiers is EqualUnmodifiableListView) return _emptiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_emptiers);
}


/// Create a copy of StarterItems
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StarterItemsCopyWith<_StarterItems> get copyWith => __$StarterItemsCopyWithImpl<_StarterItems>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StarterItemsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StarterItems&&const DeepCollectionEquality().equals(other._fillers, _fillers)&&const DeepCollectionEquality().equals(other._emptiers, _emptiers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fillers),const DeepCollectionEquality().hash(_emptiers));

@override
String toString() {
  return 'StarterItems(fillers: $fillers, emptiers: $emptiers)';
}


}

/// @nodoc
abstract mixin class _$StarterItemsCopyWith<$Res> implements $StarterItemsCopyWith<$Res> {
  factory _$StarterItemsCopyWith(_StarterItems value, $Res Function(_StarterItems) _then) = __$StarterItemsCopyWithImpl;
@override @useResult
$Res call({
 List<StarterItem> fillers, List<StarterItem> emptiers
});




}
/// @nodoc
class __$StarterItemsCopyWithImpl<$Res>
    implements _$StarterItemsCopyWith<$Res> {
  __$StarterItemsCopyWithImpl(this._self, this._then);

  final _StarterItems _self;
  final $Res Function(_StarterItems) _then;

/// Create a copy of StarterItems
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fillers = null,Object? emptiers = null,}) {
  return _then(_StarterItems(
fillers: null == fillers ? _self._fillers : fillers // ignore: cast_nullable_to_non_nullable
as List<StarterItem>,emptiers: null == emptiers ? _self._emptiers : emptiers // ignore: cast_nullable_to_non_nullable
as List<StarterItem>,
  ));
}


}

// dart format on
