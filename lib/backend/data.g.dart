// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReferenceJson _$$_ReferenceJsonFromJson(Map<String, dynamic> json) =>
    _$_ReferenceJson(
      json['index'] as int,
      $enumDecode(_$WordTypeEnumMap, json['wordType']),
    );

Map<String, dynamic> _$$_ReferenceJsonToJson(_$_ReferenceJson instance) =>
    <String, dynamic>{
      'index': instance.index,
      'wordType': _$WordTypeEnumMap[instance.wordType]!,
    };

const _$WordTypeEnumMap = {
  WordType.Noun: 'Noun',
  WordType.Verb: 'Verb',
  WordType.Adjective: 'Adjective',
  WordType.Satellite: 'Satellite',
  WordType.Adverb: 'Adverb',
};
