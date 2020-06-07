import 'package:budget_app/screens/year_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../helpers/mocks.dart';
import '../../helpers/stubs.dart';

void main() {
  testWidgets("data loads on screen", (WidgetTester tester) async {
    final user = FirebaseUserMock();
    final transactionsService = TransactionsServiceMock();

    stubUserId(user);
    stubTransactionsPerYear(transactionsService, user, 2020);
    final mockProviders = providersWithStubbedValues(transactionsService, user);

    await tester.pumpWidget(
      MultiProvider(
        providers: mockProviders,
        child: MaterialApp(
          home: YearTransactionsScreen(),
        ),
      ),
    );

    await tester.pump(Duration.zero);

    expect(find.text('70.00'), findsOneWidget);
  });
}
