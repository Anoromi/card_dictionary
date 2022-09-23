import 'package:drift/drift.dart';

class JsonConverter<T> extends TypeConverter<T, String> {
  final String Function(T) toJson;
  final T Function(String) fromJson;

  const JsonConverter(this.toJson, this.fromJson);

  @override
  T fromSql(String fromDb) {
    return fromJson(fromDb);
  }

  @override
  String toSql(T value) {
    return toJson(value);
  }
}
