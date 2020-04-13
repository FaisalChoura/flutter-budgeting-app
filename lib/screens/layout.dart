import 'package:budget_app/screens/profile.dart';
import 'package:budget_app/screens/screens.dart';
import 'package:budget_app/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  LayoutScreen({Key key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _currentIndex = 0;
  List<Widget> _children = [YearViewScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
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
        onPressed: () async {},
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
