import 'package:budget_app/screens/profile.dart';
import 'package:budget_app/services/db.dart';
import 'package:budget_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

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

  // TODO look more into animations
  // This is route animation reference
  // Route _newTransactionRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         NewTransactionScreen(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(0.0, 1.0);
  //       var end = Offset.zero;
  //       var curve = Curves.ease;
  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //       var offsetAnimation = animation.drive(tween);
  //       return SlideTransition(
  //         position: offsetAnimation,
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildStackedPages(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
      floatingActionButton: AddTransactionFloatingButton(),
    );
  }
}

class AddTransactionFloatingButton extends StatefulWidget {
  @override
  _AddTransactionFloatingButtonState createState() =>
      _AddTransactionFloatingButtonState();
}

class _AddTransactionFloatingButtonState
    extends State<AddTransactionFloatingButton> {
  bool showFab = true;

  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 31, 109, 255),
            child: Center(
              child: Icon(
                Icons.add,
                size: 32.0,
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  child: NewTransactionScreen(),
                ),
              );
            },
          )
        : Container();
  }

  void toggleFloatingButton(bool val) {
    setState(() {
      showFab = val;
    });
  }
}
