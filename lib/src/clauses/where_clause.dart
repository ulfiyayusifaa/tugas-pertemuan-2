// where_clause.dart

import '../core/query.dart';
import '../core/conditional.dart';
import '../enums/sql_logical.dart';
import '../enums/sql_operator.dart';
import 'condition.dart';

class WhereClause implements Query, Conditional {
  final List<String> _outerStack = [];
  final List<String> _groupStack = [];
  bool isGroup = false;

  List<String> get _activeStack => isGroup ? _groupStack : _outerStack;

  void addCondition(String column, SqlOperator operator, dynamic value) {
    final condition = Condition(column, operator, value);
    _activeStack.add(condition.build());
  }

  void or() {
    _activeStack.add(SqlLogical.or.toString());
  }

  void and() {
    _activeStack.add(SqlLogical.and.toString());
  }

  void startGroup() {
    _outerStack.add('(');
    isGroup = true;
  }

  void endGroup() {
    isGroup = false;
    _outerStack.add(_groupStack.join(' '));
    _outerStack.add(')');
    _groupStack.clear();
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
    return 'WHERE ${_outerStack.join(' ')}';
  }
}