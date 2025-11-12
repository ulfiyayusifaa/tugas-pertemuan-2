import '../enums/sql_operator.dart';

class Condition {
  final String column;
  final SqlOperator operator;
  final dynamic value;

  Condition(this.column, this.operator, this.value);

  String build() {
    final formattedValue = _formatValue(value);
    return '$column ${operator.symbol} $formattedValue';
  }

  String _formatValue(dynamic value) {
    if (value is String) {
      return "'$value'";
    }
    return value.toString();
  }
}
