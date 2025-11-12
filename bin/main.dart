import 'package:main/src/enums/sql_operator.dart';
import 'package:main/src/queries/select_query.dart';

void main() {
  final query1 = SelectQuery();
  query1
    .from("orders")
    .group((w) {
      w.addCondition("status", SqlOperator.equals, "Pending");
      w.or();
      w.addCondition("status", SqlOperator.equals, "Shipping");
    })
    .and()
    .where("total", SqlOperator.greaterThan, 100);

  print('SQL: ${query1.build()}');
}
