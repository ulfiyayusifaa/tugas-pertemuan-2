import '../core/query.dart';
import '../core/conditional.dart';
import '../enums/sql_logical.dart';
import '../enums/sql_operator.dart';
import 'condition.dart';

class WhereClause implements Query, Conditional {
  final List<String> _outerStack = [];

  void addCondition(String column, SqlOperator operator, dynamic value) {
    final condition = Condition(column, operator, value);
    _outerStack.add(condition.build());
  }

  void or() {
    _outerStack.add(SqlLogical.or.toString());
  }

  void and() {
    _outerStack.add(SqlLogical.and.toString());
  }

  @override
  String build() {
    return buildCondition();
  }

  @override
  String buildCondition() {
    if (_outerStack.isEmpty) {
      return '';
    }
    return ' WHERE ${_outerStack.join(' ')}';
  } }
