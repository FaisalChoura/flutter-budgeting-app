import 'package:budget_app/providers/app_providers/spending_year_provider.dart';
import 'package:budget_app/services/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/constants.dart';

void main() {
  group("Spending Year Provider", () {
    test("build month list", () {
      final spendingYear = new SpendingYear();
      final transactions = [eatingOut1, eatingOut2, shopping];
      spendingYear.buildMonthsList(transactions);
      expect(spendingYear.totalSpending, 70);
      var currentMonth = DateTime.now().month;
      expect(monthNameToNumber(spendingYear.months.first.name), currentMonth);
      expect(spendingYear.months.first.amount, 70);
    });
  });
}
