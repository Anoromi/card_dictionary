import 'dart:collection';

import 'package:drift/drift.dart';
import 'package:wordnet_dictionary_app/backend/card_database.dart';
import 'package:wordnet_dictionary_app/backend/data.dart';
import 'package:wordnet_dictionary_app/backend/tables.dart';
import 'package:wordnet_dictionary_app/bridge_generated.dart';
import 'package:wordnet_dictionary_app/general/list.dart';
import 'package:wordnet_dictionary_app/lib.dart';

part "card_daos.g.dart";

const newItemsId = 1;

@DriftAccessor(tables: [CardPack, Term, Definition, DefinitionToTerm])
class CardsDao extends DatabaseAccessor<AppDatabase> with _$CardsDaoMixin {
  CardsDao(super.attachedDatabase);

  Future<void> addToNew(FullTerm fullTerm, UnwrappedData data) async {
    await transaction(() async {
      SimpleSelectStatement<$DefinitionTable, DefinitionData>
          getDefinitionRow() {
        return ((select(definition)
          ..where((tbl) =>
              tbl.cardId.equals(newItemsId) &
              tbl.definition.equals(data.definition))));
      }

      DefinitionData definitionRow =
          await getDefinitionRow().getSingleOrNull() ??
              await () async {
                await into(definition).insert(DefinitionCompanion.insert(
                    cardId: newItemsId, definition: data.definition));
                return await getDefinitionRow().getSingle();
              }();

      final lowercaseWords = data.words.map(
        (e) => e.toLowerCase(),
      );
      await (into(term)).insert(
          TermCompanion.insert(cardId: newItemsId, name: fullTerm.term),
          mode: InsertMode.insertOrIgnore);
      final connectedTerms = await (select(term)
            ..where((tbl) =>
                tbl.cardId.equals(newItemsId) & tbl.name.isIn(lowercaseWords)))
          .get();

      await batch((batch) {
        batch.insertAll(
            definitionToTerm,
            connectedTerms.map((e) => DefinitionToTermCompanion.insert(
                termId: e.id,
                definitionId: definitionRow.id,
                cardId: newItemsId)),
            mode: InsertMode.insertOrIgnore);
      });

      final definitionFilter = fullTerm.data
          .map((e) => e.definition)
          .where((element) => element != data.definition)
          .toList();

      final addedTerm = await (select(term)
            ..where((tbl) =>
                tbl.cardId.equals(newItemsId) & tbl.name.equals(fullTerm.term)))
          .getSingle();

      final existingDefinitions = await (select(definition)
            ..where((tbl) =>
                tbl.id.equals(newItemsId) &
                tbl.definition.isIn(definitionFilter)))
          .get();

      await batch((batch) {
        batch.insertAll(
            definitionToTerm,
            existingDefinitions.map((e) => DefinitionToTermCompanion.insert(
                termId: addedTerm.id, definitionId: e.id, cardId: newItemsId)),
            mode: InsertMode.insertOrIgnore);
      });
    });
  }

  Future<CardInformation> getCardInformation(int cardId) async {
    final pack = await (select(cardPack)
          ..where(
            (tbl) => tbl.id.equals(cardId),
          ))
        .getSingle();
    final terms =
        await (select(term)..where((tbl) => tbl.cardId.equals(cardId))).get();
    final termMap = HashMap<int, DisplayTerm>();
    termMap.addEntries(
        terms.map((e) => MapEntry(e.id, DisplayTerm(e.id, e.name, HashSet()))));

    final definitionMap = HashMap.fromEntries((await (select(definition)
              ..where((tbl) => tbl.cardId.equals(cardId)))
            .get())
        .map((e) =>
            MapEntry(e.id, DisplayDefinition(e.id, e.definition, HashSet()))));

    final connections = await (select(definitionToTerm)
          ..where((tbl) => tbl.cardId.equals(cardId)))
        .get();

    for (var connection in connections) {
      final term = termMap[connection.termId]!;
      final definition = definitionMap[connection.definitionId]!;
      term.connections.add(definition);
      definition.connections.add(term);
    }
    return CardInformation(
        pack, termMap.values.toList(), definitionMap.values.toList());
  }

  Future<void> unloadNew(String toCardPack) {
    return transaction(() async {
      final cardPack = await into(this.cardPack).insertReturning(
          CardPackCompanion.insert(
              name: toCardPack, lastAccessed: DateTime.now()));
      await (update(term)..where((tbl) => tbl.cardId.equals(newItemsId)))
          .write(TermCompanion(cardId: Value(cardPack.id)));
      await (update(definition)..where((tbl) => tbl.cardId.equals(newItemsId)))
          .write(DefinitionCompanion(cardId: Value(cardPack.id)));
      await (update(definitionToTerm)
            ..where((tbl) => tbl.cardId.equals(newItemsId)))
          .write(DefinitionToTermCompanion(cardId: Value(cardPack.id)));
    });
  }

  Future<bool> packNameUnused(String name) async {
    return await (select(cardPack)
              ..where((tbl) => tbl.name.collate(Collate.noCase).equals(name)))
            .getSingleOrNull() ==
        null;
  }

  Stream<List<CardPackData>> watchRecentCardPacks(int skip, int limit) async* {
    final result = (select(cardPack)
          ..where((tbl) => tbl.id.equals(1).not())
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.lastAccessed)])
          ..limit(limit, offset: skip))
        .watch();

    yield* result;
  }

  Future<int> getCardPacksCount() async {
    final count = cardPack.id.count();
    return (await (selectOnly(cardPack)..addColumns([count])).getSingle())
        .read(count)!;
  }

  Future<UseOption> used(String term, String definition) async {
    Future<bool> exists(SimpleSelectStatement s) async {
      final result = await s.getSingleOrNull();
      return result != null;
    }

    final termInNew = select(this.term)
      ..where((tbl) => tbl.cardId.equals(newItemsId) & tbl.name.equals(term));
    final definitionInNew = select(this.definition)
      ..where((tbl) =>
          tbl.cardId.equals(newItemsId) & tbl.definition.equals(definition));

    if (await exists(termInNew) && await exists(definitionInNew)) {
      return UseOption.inRecent;
    }

    final connectionExists = (select(definitionToTerm).join([
      innerJoin(this.term, this.term.id.equalsExp(definitionToTerm.termId)),
      innerJoin(this.definition,
          this.definition.id.equalsExp(definitionToTerm.definitionId)),
    ]))
      ..where(this.term.name.equals(term) &
          this.definition.definition.equals(definition));
    return (await connectionExists.getSingleOrNull()) != null
        ? UseOption.exists
        : UseOption.no;
  }
}

enum UseOption { inRecent, exists, no }

@DriftAccessor(tables: [Recents])
class RecentsDao extends DatabaseAccessor<AppDatabase> with _$RecentsDaoMixin {
  RecentsDao(super.attachedDatabase);

  Future<List<Recent>> getRecents(int skip, int limit) async {
    final result = await (select(recents)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])
          ..limit(limit, offset: skip))
        .get();
    return result;
  }

  Stream<int> recentsCount() async* {
    final count = recents.id.count();
    final result = (selectOnly(recents)..addColumns([count])).watchSingle();

    yield* result.map(
      (event) => event.read(count)!,
    );
  }

  Future<void> addRecent(PartialTerm term) async {
    await (into(recents).insert(
        RecentsCompanion.insert(
            term: term.term,
            relations: term.references.mapList(
              (v) => ReferenceJson.fromReference(v),
            )),
        mode: InsertMode.insertOrReplace));
  }
}
