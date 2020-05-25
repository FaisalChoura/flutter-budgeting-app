import 'package:budget_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'global_providers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: routes,
      ),
    );
  }
}
