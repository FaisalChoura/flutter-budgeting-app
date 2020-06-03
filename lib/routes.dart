import 'package:flutter/material.dart';
import './screens/screens.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => LoginScreen(),
  '/home': (context) => LayoutScreen(),
  '/new-transaction': (context) => NewTransactionScreen(),
};
