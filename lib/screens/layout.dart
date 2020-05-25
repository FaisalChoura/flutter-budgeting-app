import 'package:budget_app/screens/profile.dart';
import 'package:budget_app/services/db.dart';
import 'package:budget_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens.dart';

class LayoutScreen extends StatefulWidget {
  LayoutScreen({Key key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  final TransactionsService transactionsService = TransactionsService();
  int _currentIndex = 0;
  List<Widget> _pages = [
    Navigator(onGenerateRoute: (RouteSettings settings) {
      WidgetBuilder builder;
      switch (settings.name) {
        case '/':
          builder = (BuildContext _) => YearTransactionsScreen();
          break;
        default:
          throw Exception('Invalid route: ${settings.name}');
      }
      return MaterialPageRoute(builder: builder, settings: settings);
    }),
    ProfileScreen()
  ];

  Stack _buildStackedPages() {
    List<Widget> children = [];
    _pages.asMap().forEach((index, value) {
      children.add(
        Offstage(
          offstage: _currentIndex != index,
          child: TickerMode(
            enabled: _currentIndex == index,
            child: value,
          ),
        ),
      );
    });

    return Stack(children: children);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStackedPages(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 31, 109, 255),
        child: Center(
          child: Icon(
            Icons.add,
            size: 32.0,
          ),
        ),
        onPressed: () => {
          transactionsService
              .addTransaction(Provider.of<FirebaseUser>(context, listen: false))
        },
      ),
      bottomNavigationBar: BottomNav(
        color: Color.fromARGB(255, 82, 89, 102),
        selectedColor: Color.fromARGB(255, 31, 109, 255),
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavItem(iconData: Icons.dashboard, text: 'Spendings'),
          BottomNavItem(iconData: Icons.account_circle, text: 'Profile'),
        ],
      ),
    );
  }
}
