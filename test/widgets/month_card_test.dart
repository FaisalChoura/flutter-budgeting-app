import 'package:budget_app/models/models.dart';
import 'package:budget_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Month Card", () {
    testWidgets("Month card shows correct month data",
        (WidgetTester tester) async {
      final month = Month(name: "November");
      final date = new DateTime.utc(2020, 11, 20);
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
          date: Timestamp.fromDate(date));

      month.addTransactions([eatingOut1, eatingOut2]);
      await tester.pumpWidget(
        MaterialApp(
          home: MonthCard(
            month: month,
          ),
        ),
      );

      final nameFinder = find.text("November");
      final amountFinder = find.text("£ 40.0");

      expect(nameFinder, findsOneWidget);
      expect(amountFinder, findsOneWidget);
    });
  });
}
