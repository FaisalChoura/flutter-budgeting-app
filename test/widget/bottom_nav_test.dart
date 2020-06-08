import 'package:budget_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Bottom Nav Widget", () {
    testWidgets('Change index when clicking navbar button',
        (WidgetTester tester) async {
      var index = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNav(
              color: Color.fromARGB(255, 82, 89, 102),
              selectedColor: Color.fromARGB(255, 31, 109, 255),
              items: [
                BottomNavItem(iconData: Icons.dashboard, text: 'Spendings'),
                BottomNavItem(iconData: Icons.account_circle, text: 'Profile'),
              ],
              onTabSelected: (int x) {
                index = x;
              },
            ),
          ),
        ),
      );
      const key = Key("navItem1");
      await tester.tap(find.byKey(key));

      await tester.pump();

      expect(index, 1);
    });
  });
}
