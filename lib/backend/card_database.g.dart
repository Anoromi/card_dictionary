// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CardPackData extends DataClass implements Insertable<CardPackData> {
  final int id;
  final String name;
  final DateTime lastAccessed;
  const CardPackData(
      {required this.id, required this.name, required this.lastAccessed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['last_accessed'] = Variable<DateTime>(lastAccessed);
    return map;
  }

  CardPackCompanion toCompanion(bool nullToAbsent) {
    return CardPackCompanion(
      id: Value(id),
      name: Value(name),
      lastAccessed: Value(lastAccessed),
    );
  }

  factory CardPackData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardPackData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastAccessed: serializer.fromJson<DateTime>(json['lastAccessed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastAccessed': serializer.toJson<DateTime>(lastAccessed),
    };
  }

  CardPackData copyWith({int? id, String? name, DateTime? lastAccessed}) =>
      CardPackData(
        id: id ?? this.id,
        name: name ?? this.name,
        lastAccessed: lastAccessed ?? this.lastAccessed,
      );
  @override
  String toString() {
    return (StringBuffer('CardPackData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, lastAccessed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardPackData &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastAccessed == this.lastAccessed);
}

class CardPackCompanion extends UpdateCompanion<CardPackData> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> lastAccessed;
  const CardPackCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastAccessed = const Value.absent(),
  });
  CardPackCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime lastAccessed,
  })  : name = Value(name),
        lastAccessed = Value(lastAccessed);
  static Insertable<CardPackData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? lastAccessed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastAccessed != null) 'last_accessed': lastAccessed,
    });
  }

  CardPackCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<DateTime>? lastAccessed}) {
    return CardPackCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastAccessed: lastAccessed ?? this.lastAccessed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastAccessed.present) {
      map['last_accessed'] = Variable<DateTime>(lastAccessed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardPackCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastAccessed: $lastAccessed')
          ..write(')'))
        .toString();
  }
}

class $CardPackTable extends CardPack
    with TableInfo<$CardPackTable, CardPackData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardPackTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE COLLATE NOCASE');
  final VerificationMeta _lastAccessedMeta =
      const VerificationMeta('lastAccessed');
  @override
  late final GeneratedColumn<DateTime> lastAccessed = GeneratedColumn<DateTime>(
      'last_accessed', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, lastAccessed];
  @override
  String get aliasedName => _alias ?? 'card_pack';
  @override
  String get actualTableName => 'card_pack';
  @override
  VerificationContext validateIntegrity(Insertable<CardPackData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('last_accessed')) {
      context.handle(
          _lastAccessedMeta,
          lastAccessed.isAcceptableOrUnknown(
              data['last_accessed']!, _lastAccessedMeta));
    } else if (isInserting) {
      context.missing(_lastAccessedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardPackData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardPackData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      lastAccessed: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_accessed'])!,
    );
  }

  @override
  $CardPackTable createAlias(String alias) {
    return $CardPackTable(attachedDatabase, alias);
  }
}

class TermData extends DataClass implements Insertable<TermData> {
  final int id;
  final int cardId;
  final String name;
  const TermData({required this.id, required this.cardId, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['name'] = Variable<String>(name);
    return map;
  }

  TermCompanion toCompanion(bool nullToAbsent) {
    return TermCompanion(
      id: Value(id),
      cardId: Value(cardId),
      name: Value(name),
    );
  }

  factory TermData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TermData(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'name': serializer.toJson<String>(name),
    };
  }

  TermData copyWith({int? id, int? cardId, String? name}) => TermData(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('TermData(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TermData &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.name == this.name);
}

class TermCompanion extends UpdateCompanion<TermData> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<String> name;
  const TermCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.name = const Value.absent(),
  });
  TermCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required String name,
  })  : cardId = Value(cardId),
        name = Value(name);
  static Insertable<TermData> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (name != null) 'name': name,
    });
  }

  TermCompanion copyWith(
      {Value<int>? id, Value<int>? cardId, Value<String>? name}) {
    return TermCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TermTable extends Term with TableInfo<$TermTable, TermData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES card_pack (id)');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, cardId, name];
  @override
  String get aliasedName => _alias ?? 'term';
  @override
  String get actualTableName => 'term';
  @override
  VerificationContext validateIntegrity(Insertable<TermData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {cardId, name},
      ];
  @override
  TermData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TermData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $TermTable createAlias(String alias) {
    return $TermTable(attachedDatabase, alias);
  }
}

class DefinitionData extends DataClass implements Insertable<DefinitionData> {
  final int id;
  final int cardId;
  final String definition;
  const DefinitionData(
      {required this.id, required this.cardId, required this.definition});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['card_id'] = Variable<int>(cardId);
    map['definition'] = Variable<String>(definition);
    return map;
  }

  DefinitionCompanion toCompanion(bool nullToAbsent) {
    return DefinitionCompanion(
      id: Value(id),
      cardId: Value(cardId),
      definition: Value(definition),
    );
  }

  factory DefinitionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DefinitionData(
      id: serializer.fromJson<int>(json['id']),
      cardId: serializer.fromJson<int>(json['cardId']),
      definition: serializer.fromJson<String>(json['definition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cardId': serializer.toJson<int>(cardId),
      'definition': serializer.toJson<String>(definition),
    };
  }

  DefinitionData copyWith({int? id, int? cardId, String? definition}) =>
      DefinitionData(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        definition: definition ?? this.definition,
      );
  @override
  String toString() {
    return (StringBuffer('DefinitionData(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, definition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DefinitionData &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.definition == this.definition);
}

class DefinitionCompanion extends UpdateCompanion<DefinitionData> {
  final Value<int> id;
  final Value<int> cardId;
  final Value<String> definition;
  const DefinitionCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.definition = const Value.absent(),
  });
  DefinitionCompanion.insert({
    this.id = const Value.absent(),
    required int cardId,
    required String definition,
  })  : cardId = Value(cardId),
        definition = Value(definition);
  static Insertable<DefinitionData> custom({
    Expression<int>? id,
    Expression<int>? cardId,
    Expression<String>? definition,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (definition != null) 'definition': definition,
    });
  }

  DefinitionCompanion copyWith(
      {Value<int>? id, Value<int>? cardId, Value<String>? definition}) {
    return DefinitionCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      definition: definition ?? this.definition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DefinitionCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('definition: $definition')
          ..write(')'))
        .toString();
  }
}

class $DefinitionTable extends Definition
    with TableInfo<$DefinitionTable, DefinitionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DefinitionTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES card_pack (id)');
  final VerificationMeta _definitionMeta = const VerificationMeta('definition');
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
      'definition', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, cardId, definition];
  @override
  String get aliasedName => _alias ?? 'definition';
  @override
  String get actualTableName => 'definition';
  @override
  VerificationContext validateIntegrity(Insertable<DefinitionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('definition')) {
      context.handle(
          _definitionMeta,
          definition.isAcceptableOrUnknown(
              data['definition']!, _definitionMeta));
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {cardId, definition},
      ];
  @override
  DefinitionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DefinitionData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cardId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
      definition: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}definition'])!,
    );
  }

  @override
  $DefinitionTable createAlias(String alias) {
    return $DefinitionTable(attachedDatabase, alias);
  }
}

class DefinitionToTermData extends DataClass
    implements Insertable<DefinitionToTermData> {
  final int id;
  final int termId;
  final int definitionId;
  final int cardId;
  const DefinitionToTermData(
      {required this.id,
      required this.termId,
      required this.definitionId,
      required this.cardId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['term_id'] = Variable<int>(termId);
    map['definition_id'] = Variable<int>(definitionId);
    map['card_id'] = Variable<int>(cardId);
    return map;
  }

  DefinitionToTermCompanion toCompanion(bool nullToAbsent) {
    return DefinitionToTermCompanion(
      id: Value(id),
      termId: Value(termId),
      definitionId: Value(definitionId),
      cardId: Value(cardId),
    );
  }

  factory DefinitionToTermData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DefinitionToTermData(
      id: serializer.fromJson<int>(json['id']),
      termId: serializer.fromJson<int>(json['termId']),
      definitionId: serializer.fromJson<int>(json['definitionId']),
      cardId: serializer.fromJson<int>(json['cardId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'termId': serializer.toJson<int>(termId),
      'definitionId': serializer.toJson<int>(definitionId),
      'cardId': serializer.toJson<int>(cardId),
    };
  }

  DefinitionToTermData copyWith(
          {int? id, int? termId, int? definitionId, int? cardId}) =>
      DefinitionToTermData(
        id: id ?? this.id,
        termId: termId ?? this.termId,
        definitionId: definitionId ?? this.definitionId,
        cardId: cardId ?? this.cardId,
      );
  @override
  String toString() {
    return (StringBuffer('DefinitionToTermData(')
          ..write('id: $id, ')
          ..write('termId: $termId, ')
          ..write('definitionId: $definitionId, ')
          ..write('cardId: $cardId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, termId, definitionId, cardId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DefinitionToTermData &&
          other.id == this.id &&
          other.termId == this.termId &&
          other.definitionId == this.definitionId &&
          other.cardId == this.cardId);
}

class DefinitionToTermCompanion extends UpdateCompanion<DefinitionToTermData> {
  final Value<int> id;
  final Value<int> termId;
  final Value<int> definitionId;
  final Value<int> cardId;
  const DefinitionToTermCompanion({
    this.id = const Value.absent(),
    this.termId = const Value.absent(),
    this.definitionId = const Value.absent(),
    this.cardId = const Value.absent(),
  });
  DefinitionToTermCompanion.insert({
    this.id = const Value.absent(),
    required int termId,
    required int definitionId,
    required int cardId,
  })  : termId = Value(termId),
        definitionId = Value(definitionId),
        cardId = Value(cardId);
  static Insertable<DefinitionToTermData> custom({
    Expression<int>? id,
    Expression<int>? termId,
    Expression<int>? definitionId,
    Expression<int>? cardId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (termId != null) 'term_id': termId,
      if (definitionId != null) 'definition_id': definitionId,
      if (cardId != null) 'card_id': cardId,
    });
  }

  DefinitionToTermCompanion copyWith(
      {Value<int>? id,
      Value<int>? termId,
      Value<int>? definitionId,
      Value<int>? cardId}) {
    return DefinitionToTermCompanion(
      id: id ?? this.id,
      termId: termId ?? this.termId,
      definitionId: definitionId ?? this.definitionId,
      cardId: cardId ?? this.cardId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (termId.present) {
      map['term_id'] = Variable<int>(termId.value);
    }
    if (definitionId.present) {
      map['definition_id'] = Variable<int>(definitionId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<int>(cardId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DefinitionToTermCompanion(')
          ..write('id: $id, ')
          ..write('termId: $termId, ')
          ..write('definitionId: $definitionId, ')
          ..write('cardId: $cardId')
          ..write(')'))
        .toString();
  }
}

class $DefinitionToTermTable extends DefinitionToTerm
    with TableInfo<$DefinitionToTermTable, DefinitionToTermData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DefinitionToTermTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _termIdMeta = const VerificationMeta('termId');
  @override
  late final GeneratedColumn<int> termId = GeneratedColumn<int>(
      'term_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES term (id)');
  final VerificationMeta _definitionIdMeta =
      const VerificationMeta('definitionId');
  @override
  late final GeneratedColumn<int> definitionId = GeneratedColumn<int>(
      'definition_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES definition (id)');
  final VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<int> cardId = GeneratedColumn<int>(
      'card_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES card_pack (id)');
  @override
  List<GeneratedColumn> get $columns => [id, termId, definitionId, cardId];
  @override
  String get aliasedName => _alias ?? 'definition_to_term';
  @override
  String get actualTableName => 'definition_to_term';
  @override
  VerificationContext validateIntegrity(
      Insertable<DefinitionToTermData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('term_id')) {
      context.handle(_termIdMeta,
          termId.isAcceptableOrUnknown(data['term_id']!, _termIdMeta));
    } else if (isInserting) {
      context.missing(_termIdMeta);
    }
    if (data.containsKey('definition_id')) {
      context.handle(
          _definitionIdMeta,
          definitionId.isAcceptableOrUnknown(
              data['definition_id']!, _definitionIdMeta));
    } else if (isInserting) {
      context.missing(_definitionIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {termId, definitionId},
      ];
  @override
  DefinitionToTermData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DefinitionToTermData(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      termId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}term_id'])!,
      definitionId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}definition_id'])!,
      cardId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}card_id'])!,
    );
  }

  @override
  $DefinitionToTermTable createAlias(String alias) {
    return $DefinitionToTermTable(attachedDatabase, alias);
  }
}

class Recent extends DataClass implements Insertable<Recent> {
  final int id;
  final String term;
  final List<ReferenceJson> relations;
  const Recent({required this.id, required this.term, required this.relations});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['term'] = Variable<String>(term);
    {
      final converter = $RecentsTable.$converter0;
      map['relations'] = Variable<String>(converter.toSql(relations));
    }
    return map;
  }

  RecentsCompanion toCompanion(bool nullToAbsent) {
    return RecentsCompanion(
      id: Value(id),
      term: Value(term),
      relations: Value(relations),
    );
  }

  factory Recent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recent(
      id: serializer.fromJson<int>(json['id']),
      term: serializer.fromJson<String>(json['term']),
      relations: serializer.fromJson<List<ReferenceJson>>(json['relations']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'term': serializer.toJson<String>(term),
      'relations': serializer.toJson<List<ReferenceJson>>(relations),
    };
  }

  Recent copyWith({int? id, String? term, List<ReferenceJson>? relations}) =>
      Recent(
        id: id ?? this.id,
        term: term ?? this.term,
        relations: relations ?? this.relations,
      );
  @override
  String toString() {
    return (StringBuffer('Recent(')
          ..write('id: $id, ')
          ..write('term: $term, ')
          ..write('relations: $relations')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, term, relations);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recent &&
          other.id == this.id &&
          other.term == this.term &&
          other.relations == this.relations);
}

class RecentsCompanion extends UpdateCompanion<Recent> {
  final Value<int> id;
  final Value<String> term;
  final Value<List<ReferenceJson>> relations;
  const RecentsCompanion({
    this.id = const Value.absent(),
    this.term = const Value.absent(),
    this.relations = const Value.absent(),
  });
  RecentsCompanion.insert({
    this.id = const Value.absent(),
    required String term,
    required List<ReferenceJson> relations,
  })  : term = Value(term),
        relations = Value(relations);
  static Insertable<Recent> custom({
    Expression<int>? id,
    Expression<String>? term,
    Expression<String>? relations,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (term != null) 'term': term,
      if (relations != null) 'relations': relations,
    });
  }

  RecentsCompanion copyWith(
      {Value<int>? id,
      Value<String>? term,
      Value<List<ReferenceJson>>? relations}) {
    return RecentsCompanion(
      id: id ?? this.id,
      term: term ?? this.term,
      relations: relations ?? this.relations,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (relations.present) {
      final converter = $RecentsTable.$converter0;
      map['relations'] = Variable<String>(converter.toSql(relations.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentsCompanion(')
          ..write('id: $id, ')
          ..write('term: $term, ')
          ..write('relations: $relations')
          ..write(')'))
        .toString();
  }
}

class $RecentsTable extends Recents with TableInfo<$RecentsTable, Recent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
      'term', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: 'UNIQUE');
  final VerificationMeta _relationsMeta = const VerificationMeta('relations');
  @override
  late final GeneratedColumnWithTypeConverter<List<ReferenceJson>, String>
      relations = GeneratedColumn<String>('relations', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<ReferenceJson>>($RecentsTable.$converter0);
  @override
  List<GeneratedColumn> get $columns => [id, term, relations];
  @override
  String get aliasedName => _alias ?? 'recents';
  @override
  String get actualTableName => 'recents';
  @override
  VerificationContext validateIntegrity(Insertable<Recent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('term')) {
      context.handle(
          _termMeta, term.isAcceptableOrUnknown(data['term']!, _termMeta));
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    context.handle(_relationsMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recent(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      term: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}term'])!,
      relations: $RecentsTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.string, data['${effectivePrefix}relations'])!),
    );
  }

  @override
  $RecentsTable createAlias(String alias) {
    return $RecentsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<ReferenceJson>, String> $converter0 =
      JsonConverter<List<ReferenceJson>>(
          (p0) => jsonEncode(p0),
          (p0) => (jsonDecode(p0) as List<dynamic>)
              .map((e) => ReferenceJson.fromJson(e))
              .toList());
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $CardPackTable cardPack = $CardPackTable(this);
  late final $TermTable term = $TermTable(this);
  late final $DefinitionTable definition = $DefinitionTable(this);
  late final $DefinitionToTermTable definitionToTerm =
      $DefinitionToTermTable(this);
  late final $RecentsTable recents = $RecentsTable(this);
  late final CardsDao cardsDao = CardsDao(this as AppDatabase);
  late final RecentsDao recentsDao = RecentsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [cardPack, term, definition, definitionToTerm, recents];
}
