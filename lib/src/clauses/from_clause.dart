import '../core/query.dart';

class FromClause implements Query {
  final String tableName;

  FromClause(this.tableName);

  @override
  String build() {
    return 'FROM $tableName';
  }
}
