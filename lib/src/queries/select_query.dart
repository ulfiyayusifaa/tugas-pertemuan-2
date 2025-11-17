import '../core/query.dart';
import '../clauses/from_clause.dart';
import '../clauses/where_clause.dart';
import '../enums/sql_operator.dart';

class SelectQuery implements Query {
  FromClause? _from;
  WhereClause? _where;

  SelectQuery(String tableName) {
    _from = FromClause(tableName);
    return this;
  }

  SelectQuery where(String column, SqlOperator operator, dynamic value) {
    _where ??= WhereClause();
    _where!.addCondition(column, operator, value);
    return this;
  }

  SelectQuery or() {
    if (_where == null) {
      throw StateError('Cannot use or() before adding a WHERE condition');
    }
    _where!.or();
    return this;
  }

  SelectQuery and() {
    if (_where == null) {
      throw StateError('Cannot use and() before adding a WHERE condition');
    }
    _where!.and();
    return this;
  }

  SelectQuery group(void Function(WhereClause) builder) {
    _where ??= WhereClause();
    _where!.startGroup();
    builder(_where!);
    _where!.endGroup();
    return this;
  }

  @override
  String build() {
    if (_from == null) {
      throw StateError('FROM clause must be specified');
    }

    final parts = ['SELECT *', _from!.build()];
    if (_where != null) {
      parts.add(_where!.buildCondition());
    }

    parts.add(';');
    return parts.join(' ');
  }
}