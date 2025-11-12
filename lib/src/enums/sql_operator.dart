enum SqlOperator {
  equals('='),
  notEquals('!='),
  greaterThan('>'),
  lessThan('<'),
  greaterThanOrEqual('>='),
  lessThanOrEqual('<=');

  final String symbol;
  const SqlOperator(this.symbol);
}
