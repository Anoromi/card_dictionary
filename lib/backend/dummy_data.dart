import 'package:flutter/foundation.dart';
import 'package:wordnet_dictionary_app/backend/card_database.dart';

Future<void> insertDummyData(AppDatabase database) async {
  Future insert(String name,
      {List<MapEntry<String, List<String>>>? cards}) async {
    final cardPack = await (database.into(database.cardPack)).insertReturning(
        CardPackCompanion.insert(name: name, lastAccessed: DateTime.now()));
    if (cards != null) {
      for (var e in cards) {
        final term = await database.into(database.term).insertReturning(
            TermCompanion.insert(cardId: cardPack.id, name: e.key));
        List<DefinitionData> definitions = [];
        for (var e in e.value) {
          final result = await (database.select(database.definition)
                ..where((tbl) => tbl.definition.equals(e)))
              .getSingleOrNull();
          if (result != null) {
            definitions.add(result);
          } else {
            definitions
                .add(await database.into(database.definition).insertReturning(
                      DefinitionCompanion.insert(
                          cardId: cardPack.id, definition: e),
                    ));
          }
        }

        for (var definition in definitions) {
          await database.into(database.definitionToTerm).insert(
              DefinitionToTermCompanion.insert(
                  termId: term.id,
                  definitionId: definition.id,
                  cardId: cardPack.id));
        }
      }
    }
  }

  await insert("example", cards: [
    const MapEntry("start", ["This is what card packs look like.\n"]),
    const MapEntry("next", [
      "Except with terms and definitions.\n"
          "Here \"next\" is the term and what you are reading now is the definition.\n"
          "And yes, one term can have several definitions.\n"
    ]),
    const MapEntry("play", ["This is what card packs look like."]),
    const MapEntry("finish", [
      "Definition also have several terms\n"
          "So \"This is what card...\" definition will have two terms when you learn the cards"
    ])
  ]);

  if (!kReleaseMode) {
    for (var i = 0; i < 100; i++) {
      await insert("test $i");
    }
  }
}
