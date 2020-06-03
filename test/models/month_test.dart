import 'package:budget_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Month", () {
    test('Add transaction', () {
      final month = Month(name: "October");
      final transaction = TransactionRec(
          id: "123456",
          name: "KFC",
          amount: 25,
          category: "Eating Out",
          date: Timestamp.now());

      month.addTransaction(transaction);

      expect(month.transactions, [transaction]);
    });

    test("Add multiple transactions", () {
      final month = Month(name: "October");
      final eatingOut1 = TransactionRec(
          id: "123456",
          name: "KFC",
          amount: 25,
          category: "Eating Out",
          date: Timestamp.now());
      final eatingOut2 = TransactionRec(
          id: "123456",
          name: "Poke",
          amount: 15,
          category: "Eating Out",
          date: Timestamp.now());
      final shopping = TransactionRec(
          id: "123456",
          name: "H&M",
          amount: 30,
          category: "Shopping",
          date: Timestamp.now());

      month.addTransactions([eatingOut1, eatingOut2, shopping]);
      expect(month.transactions.length, 3);
    });

    test("Group by category", () {
      final month = Month(name: "October");
      final eatingOut1 = TransactionRec(
          id: "123456",
          name: "KFC",
          amount: 25,
          category: "Eating Out",
          date: Timestamp.now());
      final eatingOut2 = TransactionRec(
          id: "123456",
          name: "Poke",
          amount: 15,
          category: "Eating Out",
          date: Timestamp.now());
      final shopping = TransactionRec(
          id: "123456",
          name: "H&M",
          amount: 30,
          category: "Shopping",
          date: Timestamp.now());

      month.addTransactions([eatingOut1, eatingOut2, shopping]);
      List<Category> groupedCategories = month.groupByCategory();

      expect(groupedCategories[0].name, "Eating Out");
      expect(groupedCategories[1].name, "Shopping");
      expect(groupedCategories[0].total, 40);
      expect(groupedCategories[1].total, 30);
    });
  });
}
