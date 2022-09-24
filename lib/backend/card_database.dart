import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:wordnet_dictionary_app/backend/card_daos.dart';
import 'package:wordnet_dictionary_app/backend/dummy_data.dart';
import 'package:wordnet_dictionary_app/backend/tables.dart';
import 'package:wordnet_dictionary_app/backend/data.dart';
import 'package:wordnet_dictionary_app/backend/json_converter.dart';
import 'dart:convert';

part 'card_database.g.dart';

@DriftDatabase(
    tables: [CardPack, Term, Definition, DefinitionToTerm, Recents],
    daos: [CardsDao, RecentsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          if (details.wasCreated) {
            await (into(cardPack)).insert(CardPackCompanion.insert(
                id: const Value(newItemsId),
                name: "",
                lastAccessed: DateTime(0)));

            await insertDummyData(this);
          }

          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
