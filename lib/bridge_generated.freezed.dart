// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bridge_generated.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PartialTerm {
  String get term => throw _privateConstructorUsedError;
  List<Reference> get references => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PartialTermCopyWith<PartialTerm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartialTermCopyWith<$Res> {
  factory $PartialTermCopyWith(
          PartialTerm value, $Res Function(PartialTerm) then) =
      _$PartialTermCopyWithImpl<$Res>;
  $Res call({String term, List<Reference> references});
}

/// @nodoc
class _$PartialTermCopyWithImpl<$Res> implements $PartialTermCopyWith<$Res> {
  _$PartialTermCopyWithImpl(this._value, this._then);

  final PartialTerm _value;
  // ignore: unused_field
  final $Res Function(PartialTerm) _then;

  @override
  $Res call({
    Object? term = freezed,
    Object? references = freezed,
  }) {
    return _then(_value.copyWith(
      term: term == freezed
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      references: references == freezed
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as List<Reference>,
    ));
  }
}

/// @nodoc
abstract class _$$_PartialTermCopyWith<$Res>
    implements $PartialTermCopyWith<$Res> {
  factory _$$_PartialTermCopyWith(
          _$_PartialTerm value, $Res Function(_$_PartialTerm) then) =
      __$$_PartialTermCopyWithImpl<$Res>;
  @override
  $Res call({String term, List<Reference> references});
}

/// @nodoc
class __$$_PartialTermCopyWithImpl<$Res> extends _$PartialTermCopyWithImpl<$Res>
    implements _$$_PartialTermCopyWith<$Res> {
  __$$_PartialTermCopyWithImpl(
      _$_PartialTerm _value, $Res Function(_$_PartialTerm) _then)
      : super(_value, (v) => _then(v as _$_PartialTerm));

  @override
  _$_PartialTerm get _value => super._value as _$_PartialTerm;

  @override
  $Res call({
    Object? term = freezed,
    Object? references = freezed,
  }) {
    return _then(_$_PartialTerm(
      term: term == freezed
          ? _value.term
          : term // ignore: cast_nullable_to_non_nullable
              as String,
      references: references == freezed
          ? _value._references
          : references // ignore: cast_nullable_to_non_nullable
              as List<Reference>,
    ));
  }
}

/// @nodoc

class _$_PartialTerm implements _PartialTerm {
  const _$_PartialTerm(
      {required this.term, required final List<Reference> references})
      : _references = references;

  @override
  final String term;
  final List<Reference> _references;
  @override
  List<Reference> get references {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_references);
  }

  @override
  String toString() {
    return 'PartialTerm(term: $term, references: $references)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PartialTerm &&
            const DeepCollectionEquality().equals(other.term, term) &&
            const DeepCollectionEquality()
                .equals(other._references, _references));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(term),
      const DeepCollectionEquality().hash(_references));

  @JsonKey(ignore: true)
  @override
  _$$_PartialTermCopyWith<_$_PartialTerm> get copyWith =>
      __$$_PartialTermCopyWithImpl<_$_PartialTerm>(this, _$identity);
}

abstract class _PartialTerm implements PartialTerm {
  const factory _PartialTerm(
      {required final String term,
      required final List<Reference> references}) = _$_PartialTerm;

  @override
  String get term;
  @override
  List<Reference> get references;
  @override
  @JsonKey(ignore: true)
  _$$_PartialTermCopyWith<_$_PartialTerm> get copyWith =>
      throw _privateConstructorUsedError;
}
