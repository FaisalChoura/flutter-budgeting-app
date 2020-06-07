import 'package:budget_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/constants.dart';

void main() {
  group("Month", () {
    test('Add transaction', () {
      final month = Month(name: "October");

      month.addTransaction(eatingOut1);

      expect(month.transactions, [eatingOut1]);
    });

    test("Add multiple transactions", () {
      final month = Month(name: "October");

      month.addTransactions([eatingOut1, eatingOut2, shopping]);
      expect(month.transactions.length, 3);
    });

    test("Group by category", () {
      final month = Month(name: "October");

      month.addTransactions([eatingOut1, eatingOut2, shopping]);
      List<Category> groupedCategories = month.groupByCategory();

      expect(groupedCategories[0].name, "Eating Out");
      expect(groupedCategories[1].name, "Shopping");
      expect(groupedCategories[0].total, 40);
      expect(groupedCategories[1].total, 30);
    });
  });
}
