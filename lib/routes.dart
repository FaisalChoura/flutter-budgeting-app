import 'package:flutter/material.dart';
import './screens/screens.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => LoginScreen(),
  '/year_view': (context) => YearViewScreen(),
};
