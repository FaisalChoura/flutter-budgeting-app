import 'package:budget_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../helpers/mocks.dart';
import '../helpers/stubs.dart';

void main() {
  group("New Transaction Screen", () {
    testWidgets("Correct transaction created and closed after creation",
        (WidgetTester tester) async {
      final currentMonth = DateTime.now().month;
      final currentYear = DateTime.now().year;
      await pumpLayoutScreen(tester);
      await tester.tap(find.byKey(Key("newTransactionModalButton")));
      await tester.pumpAndSettle();

      expect(find.text("New Transaction"), findsOneWidget);

      await tester.tap(find.byKey(Key("GroceriesTile")));
      await selectDate(tester);
      await tester.enterText(find.byKey(Key("amountField")), "40");
      await tester.enterText(find.byKey(Key("nameField")), "Waitrose");
      await tester.tap(find.byKey(Key("newTransactionButton")));

      final transaction = tester
          .state<NewTransactionFormState>(find.byKey(Key("newTransactionForm")))
          .transaction;
      expect(transaction.name, "Waitrose");
      expect(transaction.amount, 40);
      expect(transaction.category, "Groceries");
      final transactionDate = transaction.date.toDate();
      expect(
          "${transactionDate.year}/${transactionDate.month}/${transactionDate.day}",
          "$currentYear/$currentMonth/12");

      await tester.pumpAndSettle();
      expect(find.text("New Transaction"), findsNothing);
    });
  });

  testWidgets("Form field validations", (WidgetTester tester) async {
    await pumpLayoutScreen(tester);

    await tester.tap(find.byKey(Key("newTransactionModalButton")));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key("newTransactionButton")));
    await tester.pump();

    expect(find.text("Please select a category for your transaction"),
        findsOneWidget);
    expect(
        find.text("Please enter a date for your transaction"), findsOneWidget);
    expect(
        find.text("Please enter a name for your transaction"), findsOneWidget);
    expect(find.text("Please enter an amount for your transaction"),
        findsOneWidget);
  });
}

selectDate(WidgetTester tester) async {
  await tester.tap(find.byKey(Key("dateField")));
  await tester.pumpAndSettle();
  await tester.tap(find.text("12"));
  await tester.tap(find.text("OK"));
}

pumpLayoutScreen(WidgetTester tester) async {
  final user = FirebaseUserMock();
  final transactionsService = TransactionsServiceMock();

  stubUserId(user);
  stubTransactionsPerYear(transactionsService, user, 2020);
  stubAddTransaction(transactionsService, user);
  final mockProviders = providersWithStubbedValues(transactionsService, user);
  await tester.pumpWidget(
    MultiProvider(
      providers: mockProviders,
      child: MaterialApp(
        home: LayoutScreen(),
      ),
    ),
  );

  await tester.pump(Duration.zero);
}
