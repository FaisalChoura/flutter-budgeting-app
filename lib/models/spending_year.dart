import 'package:budget_app/models/models.dart';

class SpendingYear {
  int year;
  List<Month> months;
  double totalSpending = 0;

  SpendingYear({this.year, this.months}) {
    months.forEach((month) {
      totalSpending = totalSpending + month.amount;
    });
  }
}
