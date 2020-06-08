import 'package:budget_app/providers/providers.dart';
import 'package:budget_app/screens/year_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../helpers/mocks.dart';
import '../../helpers/stubs.dart';

void main() {
  group("Year Transaction Screen", () {
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

      final num fontSizeBeforeToggle =
          Provider.of<YearScreenProvider>(childContext, listen: false)
              .totalSpendingsFontSize;
      final num paddingBeforeToggle =
          Provider.of<YearScreenProvider>(childContext, listen: false)
              .totalSpendingsPadding;

      await tester.tap(find.byKey(Key("yearChartToggle")));
      await tester.pumpAndSettle();
      final num monthContainerHeightAfterToggle =
          Provider.of<YearScreenProvider>(childContext, listen: false)
              .monthDataContainerheight;

      expect(monthContainerHeightBeforeToggle,
          isNot(equals(monthContainerHeightAfterToggle)));
      expect(
          fontSizeBeforeToggle,
          isNot(equals(
              Provider.of<YearScreenProvider>(childContext, listen: false)
                  .totalSpendingsPadding)));
      expect(
          paddingBeforeToggle,
          isNot(equals(
              Provider.of<YearScreenProvider>(childContext, listen: false)
                  .totalSpendingsPadding)));
      expect(
          Provider.of<YearScreenProvider>(childContext, listen: false)
              .yearChartVisible,
          true);
    });

    testWidgets("Chart is toggleable", (WidgetTester tester) async {
      await pumpYearScreen(tester);

      await tester.tap(find.byKey(Key("yearChartToggle")));
      await tester.pumpAndSettle();

      AnimatedOpacity chartOpacity =
          tester.firstWidget(find.byKey(Key("yearBreakdownChartOpacity")));
      expect(chartOpacity.opacity, 1);

      await tester.tap(find.byKey(Key("yearChartToggle")));
      await tester.pumpAndSettle();

      chartOpacity =
          tester.firstWidget(find.byKey(Key("yearBreakdownChartOpacity")));

      expect(chartOpacity.opacity, 0);
    });
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
