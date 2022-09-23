import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:wordnet_dictionary_app/backend/data.dart';
import 'package:wordnet_dictionary_app/backend/json_converter.dart';

class CardPack extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique().customConstraint("COLLATE NOCASE")();
  DateTimeColumn get lastAccessed => dateTime()();
}

class Term extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer().references(CardPack, #id)();
  TextColumn get name => text()();

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {cardId, name}
      ];
}

class Definition extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cardId => integer().references(CardPack, #id)();
  TextColumn get definition => text()();
  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {cardId, definition}
      ];
}

class DefinitionToTerm extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get termId => integer().references(Term, #id)();
  IntColumn get definitionId => integer().references(Definition, #id)();
  IntColumn get cardId => integer().references(CardPack, #id)();
  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {termId, definitionId}
      ];
}

class Recents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get term => text().unique()();
  TextColumn get relations => text().map(JsonConverter<List<ReferenceJson>>(
        (p0) => jsonEncode(p0),
        (p0) => (jsonDecode(p0) as List<dynamic>)
            .map((e) => ReferenceJson.fromJson(e))
            .toList(),
      ))();
}
