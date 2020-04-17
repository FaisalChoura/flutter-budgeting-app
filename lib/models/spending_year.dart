import 'package:budget_app/models/models.dart';
import 'package:budget_app/services/helpers.dart';

class SpendingYear {
  int year;
  List<Month> months;
  double totalSpending = 0;

  SpendingYear({this.year, List<BTransaction> transactions}) {
    months = _buildMonthsList(transactions);
    months.forEach((month) {
      totalSpending = totalSpending + month.amount;
    });
  }

  List<Month> _buildMonthsList(List<BTransaction> transactions) {
    Map<int, Month> monthsMap = {};
    transactions.forEach((transaction) {
      var monthNumber = transaction.date.toDate().month;
      if (monthsMap[monthNumber] == null) {
        String monthName = monthsOfTheYear[monthNumber - 1];
        monthsMap[monthNumber] =
            new Month(amount: transaction.amount, name: monthName);
      } else {
        monthsMap[monthNumber].addTransaction(transaction);
      }
    });
    return monthsMap.values.toList();
  }
}
