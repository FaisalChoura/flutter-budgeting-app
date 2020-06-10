import 'package:budget_app/screens/screens.dart';
import 'package:budget_app/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../helpers/mocks.dart';
import '../helpers/stubs.dart';

// TODO how to test item being removed after delete firebase

void main() {
  group("Month Screen", () {
    testWidgets("Displays correct information", (WidgetTester tester) async {
      final transactionsService = TransactionsServiceMock();
      final user = FirebaseUserMock();

      await pumpMonthScreen(tester, transactionsService, user);
      expect(find.text("October"), findsOneWidget);
      expect(find.text("70.00"), findsOneWidget);
    });

    testWidgets("Menu button and Delete ", (WidgetTester tester) async {
      final transactionsService = TransactionsServiceMock();
      final user = FirebaseUserMock();

      await pumpMonthScreen(tester, transactionsService, user);

      await tester.tap(find.byKey(Key("1transactionPopupMenu")));
      await tester.pumpAndSettle();
      stubDeletedTransactionsPerMonth(transactionsService, user, 2020, 10);
      await tester.tap(find.text("Delete"));
      verify(transactionsService.deleteTransaction(argThat(isA<String>())))
          .called(1);
    });
  });
}

pumpMonthScreen(WidgetTester tester, TransactionsService transactionsService,
    FirebaseUser user) async {
  stubUserId(user);
  stubTransactionsPerMonth(transactionsService, user, 2020, 10);
  final mockProviders = providersWithStubbedValues(transactionsService, user);
  await tester.pumpWidget(
    MultiProvider(
      providers: mockProviders,
      child: MaterialApp(
        home: MonthTransactionsScreen(
          monthName: "October",
        ),
      ),
    ),
  );

  await tester.pump(Duration.zero);
}
