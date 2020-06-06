import 'package:budget_app/models/models.dart';
import 'package:budget_app/widgets/month_transactions_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Animation happens when toggle is clicked',
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
        home: Scaffold(
          body: MonthHeader(
            key: Key("monthHeader"),
            month: month,
          ),
        ),
      ),
    );
    AnimatedOpacity monthChartInitOpacity =
        tester.firstWidget(find.byKey(Key("monthBreakdownChartOpacity")));

    expect(monthChartInitOpacity.opacity, 0);

    await tester.tap(find.byKey(Key("expansionToggle")));

    await tester.pumpAndSettle();
    AnimatedOpacity monthChartAfterAnimationOpacity =
        tester.firstWidget(find.byKey(Key("monthBreakdownChartOpacity")));

    var state = tester.state<MonthHeaderState>(find.byKey(Key("monthHeader")));
    expect(monthChartAfterAnimationOpacity.opacity, 1);

    expect(state.expanded, true);
    expect(state.height, 288);
  });
}
