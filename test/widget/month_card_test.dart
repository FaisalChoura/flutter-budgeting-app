import 'package:budget_app/models/models.dart';
import 'package:budget_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/constants.dart';

void main() {
  group("Month Card Widget", () {
    testWidgets("Month card shows correct month data",
        (WidgetTester tester) async {
      final month = Month(name: "November");

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
