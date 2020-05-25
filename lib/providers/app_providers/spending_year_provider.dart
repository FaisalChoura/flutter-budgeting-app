import 'package:budget_app/models/models.dart';
import 'package:budget_app/services/constants.dart';
import 'package:budget_app/services/helpers.dart';
import 'package:flutter/foundation.dart';

class SpendingYear extends ChangeNotifier {
  int _year = DateTime.now().year;
  List<Month> months;
  double totalSpending = 0;

  SpendingYear();

  int get year => _year;
  set year(int year) {
    this._year = year;
    notifyListeners();
  }

  void buildMonthsList(List<TransactionRec> transactions) {
    this.totalSpending = 0;
    Map<int, Month> monthsMap = {};
    transactions.forEach((transaction) {
      var monthNumber = transaction.date.toDate().month;
      if (monthsMap[monthNumber] == null) {
        String monthName = monthsOfTheYear[monthNumber - 1];
        monthsMap[monthNumber] = new Month(name: monthName);
        monthsMap[monthNumber].addTransaction(transaction);
      } else {
        monthsMap[monthNumber].addTransaction(transaction);
      }
    });
    this.months = monthsMap.values.toList();
    this.months.forEach((month) {
      totalSpending = totalSpending + month.amount;
    });
  }
}
