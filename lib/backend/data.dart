import 'package:wordnet_dictionary_app/backend/card_database.dart';
import 'package:wordnet_dictionary_app/bridge_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "data.freezed.dart";
part "data.g.dart";

@Freezed(
    equal: false,
    toJson: false,
    fromJson: false,
    addImplicitFinal: false,
    makeCollectionsUnmodifiable: false)
class DisplayTerm with _$DisplayTerm {
  DisplayTerm._();
  factory DisplayTerm(int id, String text, Set<DisplayDefinition> connections) =
      _DisplayTerm;

  @override
  int get hashCode => Object.hash(id, text);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DisplayDefinition &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.text, text)
        );
  }
}

@Freezed(
    equal: false,
    toJson: false,
    fromJson: false,
    addImplicitFinal: false,
    makeCollectionsUnmodifiable: false)
class DisplayDefinition with _$DisplayDefinition {
  DisplayDefinition._();
  factory DisplayDefinition(int id, String text, Set<DisplayTerm> connections) =
      _DisplayDefinition;

  @override
  int get hashCode => Object.hash(id, text);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DisplayDefinition &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.text, text)
        );
  }
}

class Ha {}

class CardInformation {
  final CardPackData cardPack;
  final List<DisplayTerm> terms;
  final List<DisplayDefinition> definitions;

  const CardInformation(this.cardPack, this.terms, this.definitions);
}

@freezed
class ReferenceJson with _$ReferenceJson {
  const ReferenceJson._();

  const factory ReferenceJson(int index, WordType wordType) = _ReferenceJson;
  factory ReferenceJson.fromReference(Reference r) =>
      ReferenceJson(r.index, r.wordType);

  Reference toReference() => Reference(index: index, wordType: wordType);

  factory ReferenceJson.fromJson(Map<String, dynamic> json) =>
      _$ReferenceJsonFromJson(json);
}
