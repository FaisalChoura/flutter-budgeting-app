import 'package:budget_app/screens/screens.dart';
import 'package:budget_app/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../helpers/mocks.dart';
import '../helpers/stubs.dart';

// TODO what's the best way to test firestore refreshes
// Look into this https://pub.dev/packages/cloud_firestore_mocks

void main() {
  group("Month Screen", () {
    testWidgets("Displays correct information", (WidgetTester tester) async {
      final transactionsService = TransactionsServiceMock();
      final user = FirebaseUserMock();
      stubTransactionsPerMonth(transactionsService, user, 2020, 10);
      await pumpMonthScreen(tester, transactionsService, user);
      expect(find.text("October"), findsOneWidget);
      expect(find.text("70.00"), findsOneWidget);
    });

    testWidgets("Menu button and Delete ", (WidgetTester tester) async {
      final transactionsService = TransactionsServiceMock();
      final user = FirebaseUserMock();
      stubTransactionsPerMonth(transactionsService, user, 2020, 10);

      await pumpMonthScreen(tester, transactionsService, user);

      await tester.tap(find.byKey(Key("1transactionPopupMenu")));
      await tester.pumpAndSettle();
      await tester.tap(find.text("Delete"));
      transactionsService.streamTransactionsPerMonth(user, 2020, 10);
      verify(transactionsService.deleteTransaction(argThat(isA<String>())))
          .called(1);

      // stubDeletedTransactionsPerMonth(transactionsService, user, 2020, 10);
      // await pumpMonthScreen(tester, transactionsService, user);
      // expect(find.text("KFC"), findsNothing);
    });
  });
}

pumpMonthScreen(WidgetTester tester, TransactionsService transactionsService,
    FirebaseUser user) async {
  stubUserId(user);
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
