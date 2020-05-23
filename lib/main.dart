import 'package:budget_app/routes.dart';
import 'package:budget_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: AuthService().user,
        ),
        ChangeNotifierProvider<SpendingYear>(
          create: (_) => new SpendingYear(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: routes,
      ),
    );
  }
}
