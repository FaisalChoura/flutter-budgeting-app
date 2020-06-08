import 'package:budget_app/providers/providers.dart';
import 'package:budget_app/screens/year_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../helpers/mocks.dart';
import '../../helpers/stubs.dart';

void main() {
  testWidgets("data loads on screen", (WidgetTester tester) async {
    await pumpYearScreen(tester);

    expect(find.text('70.00'), findsOneWidget);
  });

  testWidgets("Chart button triggers chart container animation",
      (WidgetTester tester) async {
    await pumpYearScreen(tester);

    final BuildContext childContext =
        tester.element(find.byKey(Key("animatedYearChartContainer")));
    final num monthContainerHeightBeforeToggle =
        Provider.of<YearScreenProvider>(childContext, listen: false)
            .monthDataContainerheight;

    await tester.tap(find.byKey(Key("yearChartToggle")));
    await tester.pumpAndSettle();
    final num monthContainerHeightAfterToggle =
        Provider.of<YearScreenProvider>(childContext, listen: false)
            .monthDataContainerheight;

    expect(monthContainerHeightBeforeToggle,
        isNot(equals(monthContainerHeightAfterToggle)));
  });
}

pumpYearScreen(WidgetTester tester) async {
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
}
