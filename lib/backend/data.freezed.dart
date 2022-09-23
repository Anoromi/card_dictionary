// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DisplayTerm {
  int get id => throw _privateConstructorUsedError;
  set id(int value) => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  set text(String value) => throw _privateConstructorUsedError;
  Set<DisplayDefinition> get connections => throw _privateConstructorUsedError;
  set connections(Set<DisplayDefinition> value) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DisplayTermCopyWith<DisplayTerm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisplayTermCopyWith<$Res> {
  factory $DisplayTermCopyWith(
          DisplayTerm value, $Res Function(DisplayTerm) then) =
      _$DisplayTermCopyWithImpl<$Res>;
  $Res call({int id, String text, Set<DisplayDefinition> connections});
}

/// @nodoc
class _$DisplayTermCopyWithImpl<$Res> implements $DisplayTermCopyWith<$Res> {
  _$DisplayTermCopyWithImpl(this._value, this._then);

  final DisplayTerm _value;
  // ignore: unused_field
  final $Res Function(DisplayTerm) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? connections = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      connections: connections == freezed
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as Set<DisplayDefinition>,
    ));
  }
}

/// @nodoc
abstract class _$$_DisplayTermCopyWith<$Res>
    implements $DisplayTermCopyWith<$Res> {
  factory _$$_DisplayTermCopyWith(
          _$_DisplayTerm value, $Res Function(_$_DisplayTerm) then) =
      __$$_DisplayTermCopyWithImpl<$Res>;
  @override
  $Res call({int id, String text, Set<DisplayDefinition> connections});
}

/// @nodoc
class __$$_DisplayTermCopyWithImpl<$Res> extends _$DisplayTermCopyWithImpl<$Res>
    implements _$$_DisplayTermCopyWith<$Res> {
  __$$_DisplayTermCopyWithImpl(
      _$_DisplayTerm _value, $Res Function(_$_DisplayTerm) _then)
      : super(_value, (v) => _then(v as _$_DisplayTerm));

  @override
  _$_DisplayTerm get _value => super._value as _$_DisplayTerm;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? connections = freezed,
  }) {
    return _then(_$_DisplayTerm(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      connections == freezed
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as Set<DisplayDefinition>,
    ));
  }
}

/// @nodoc

class _$_DisplayTerm extends _DisplayTerm {
  _$_DisplayTerm(this.id, this.text, this.connections) : super._();

  @override
  int id;
  @override
  String text;
  @override
  Set<DisplayDefinition> connections;

  @override
  String toString() {
    return 'DisplayTerm(id: $id, text: $text, connections: $connections)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_DisplayTermCopyWith<_$_DisplayTerm> get copyWith =>
      __$$_DisplayTermCopyWithImpl<_$_DisplayTerm>(this, _$identity);
}

abstract class _DisplayTerm extends DisplayTerm {
  factory _DisplayTerm(
      int id, String text, Set<DisplayDefinition> connections) = _$_DisplayTerm;
  _DisplayTerm._() : super._();

  @override
  int get id;
  set id(int value);
  @override
  String get text;
  set text(String value);
  @override
  Set<DisplayDefinition> get connections;
  set connections(Set<DisplayDefinition> value);
  @override
  @JsonKey(ignore: true)
  _$$_DisplayTermCopyWith<_$_DisplayTerm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DisplayDefinition {
  int get id => throw _privateConstructorUsedError;
  set id(int value) => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  set text(String value) => throw _privateConstructorUsedError;
  Set<DisplayTerm> get connections => throw _privateConstructorUsedError;
  set connections(Set<DisplayTerm> value) => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DisplayDefinitionCopyWith<DisplayDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisplayDefinitionCopyWith<$Res> {
  factory $DisplayDefinitionCopyWith(
          DisplayDefinition value, $Res Function(DisplayDefinition) then) =
      _$DisplayDefinitionCopyWithImpl<$Res>;
  $Res call({int id, String text, Set<DisplayTerm> connections});
}

/// @nodoc
class _$DisplayDefinitionCopyWithImpl<$Res>
    implements $DisplayDefinitionCopyWith<$Res> {
  _$DisplayDefinitionCopyWithImpl(this._value, this._then);

  final DisplayDefinition _value;
  // ignore: unused_field
  final $Res Function(DisplayDefinition) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? connections = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      connections: connections == freezed
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as Set<DisplayTerm>,
    ));
  }
}

/// @nodoc
abstract class _$$_DisplayDefinitionCopyWith<$Res>
    implements $DisplayDefinitionCopyWith<$Res> {
  factory _$$_DisplayDefinitionCopyWith(_$_DisplayDefinition value,
          $Res Function(_$_DisplayDefinition) then) =
      __$$_DisplayDefinitionCopyWithImpl<$Res>;
  @override
  $Res call({int id, String text, Set<DisplayTerm> connections});
}

/// @nodoc
class __$$_DisplayDefinitionCopyWithImpl<$Res>
    extends _$DisplayDefinitionCopyWithImpl<$Res>
    implements _$$_DisplayDefinitionCopyWith<$Res> {
  __$$_DisplayDefinitionCopyWithImpl(
      _$_DisplayDefinition _value, $Res Function(_$_DisplayDefinition) _then)
      : super(_value, (v) => _then(v as _$_DisplayDefinition));

  @override
  _$_DisplayDefinition get _value => super._value as _$_DisplayDefinition;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? connections = freezed,
  }) {
    return _then(_$_DisplayDefinition(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      connections == freezed
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as Set<DisplayTerm>,
    ));
  }
}

/// @nodoc

class _$_DisplayDefinition extends _DisplayDefinition {
  _$_DisplayDefinition(this.id, this.text, this.connections) : super._();

  @override
  int id;
  @override
  String text;
  @override
  Set<DisplayTerm> connections;

  @override
  String toString() {
    return 'DisplayDefinition(id: $id, text: $text, connections: $connections)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_DisplayDefinitionCopyWith<_$_DisplayDefinition> get copyWith =>
      __$$_DisplayDefinitionCopyWithImpl<_$_DisplayDefinition>(
          this, _$identity);
}

abstract class _DisplayDefinition extends DisplayDefinition {
  factory _DisplayDefinition(
      int id, String text, Set<DisplayTerm> connections) = _$_DisplayDefinition;
  _DisplayDefinition._() : super._();

  @override
  int get id;
  set id(int value);
  @override
  String get text;
  set text(String value);
  @override
  Set<DisplayTerm> get connections;
  set connections(Set<DisplayTerm> value);
  @override
  @JsonKey(ignore: true)
  _$$_DisplayDefinitionCopyWith<_$_DisplayDefinition> get copyWith =>
      throw _privateConstructorUsedError;
}

ReferenceJson _$ReferenceJsonFromJson(Map<String, dynamic> json) {
  return _ReferenceJson.fromJson(json);
}

/// @nodoc
mixin _$ReferenceJson {
  int get index => throw _privateConstructorUsedError;
  WordType get wordType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferenceJsonCopyWith<ReferenceJson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceJsonCopyWith<$Res> {
  factory $ReferenceJsonCopyWith(
          ReferenceJson value, $Res Function(ReferenceJson) then) =
      _$ReferenceJsonCopyWithImpl<$Res>;
  $Res call({int index, WordType wordType});
}

/// @nodoc
class _$ReferenceJsonCopyWithImpl<$Res>
    implements $ReferenceJsonCopyWith<$Res> {
  _$ReferenceJsonCopyWithImpl(this._value, this._then);

  final ReferenceJson _value;
  // ignore: unused_field
  final $Res Function(ReferenceJson) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? wordType = freezed,
  }) {
    return _then(_value.copyWith(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      wordType: wordType == freezed
          ? _value.wordType
          : wordType // ignore: cast_nullable_to_non_nullable
              as WordType,
    ));
  }
}

/// @nodoc
abstract class _$$_ReferenceJsonCopyWith<$Res>
    implements $ReferenceJsonCopyWith<$Res> {
  factory _$$_ReferenceJsonCopyWith(
          _$_ReferenceJson value, $Res Function(_$_ReferenceJson) then) =
      __$$_ReferenceJsonCopyWithImpl<$Res>;
  @override
  $Res call({int index, WordType wordType});
}

/// @nodoc
class __$$_ReferenceJsonCopyWithImpl<$Res>
    extends _$ReferenceJsonCopyWithImpl<$Res>
    implements _$$_ReferenceJsonCopyWith<$Res> {
  __$$_ReferenceJsonCopyWithImpl(
      _$_ReferenceJson _value, $Res Function(_$_ReferenceJson) _then)
      : super(_value, (v) => _then(v as _$_ReferenceJson));

  @override
  _$_ReferenceJson get _value => super._value as _$_ReferenceJson;

  @override
  $Res call({
    Object? index = freezed,
    Object? wordType = freezed,
  }) {
    return _then(_$_ReferenceJson(
      index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      wordType == freezed
          ? _value.wordType
          : wordType // ignore: cast_nullable_to_non_nullable
              as WordType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReferenceJson extends _ReferenceJson {
  const _$_ReferenceJson(this.index, this.wordType) : super._();

  factory _$_ReferenceJson.fromJson(Map<String, dynamic> json) =>
      _$$_ReferenceJsonFromJson(json);

  @override
  final int index;
  @override
  final WordType wordType;

  @override
  String toString() {
    return 'ReferenceJson(index: $index, wordType: $wordType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReferenceJson &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.wordType, wordType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(wordType));

  @JsonKey(ignore: true)
  @override
  _$$_ReferenceJsonCopyWith<_$_ReferenceJson> get copyWith =>
      __$$_ReferenceJsonCopyWithImpl<_$_ReferenceJson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReferenceJsonToJson(
      this,
    );
  }
}

abstract class _ReferenceJson extends ReferenceJson {
  const factory _ReferenceJson(final int index, final WordType wordType) =
      _$_ReferenceJson;
  const _ReferenceJson._() : super._();

  factory _ReferenceJson.fromJson(Map<String, dynamic> json) =
      _$_ReferenceJson.fromJson;

  @override
  int get index;
  @override
  WordType get wordType;
  @override
  @JsonKey(ignore: true)
  _$$_ReferenceJsonCopyWith<_$_ReferenceJson> get copyWith =>
      throw _privateConstructorUsedError;
}
