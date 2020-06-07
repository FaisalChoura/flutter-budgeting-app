import 'package:budget_app/services/auth.dart';
import 'package:budget_app/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'providers/providers.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...viewProviders
];

List<SingleChildWidget> independentServices = [
  Provider(
    create: (_) => TransactionsService(),
  ),
  StreamProvider<FirebaseUser>.value(
    value: AuthService().user,
  ),
];

List<SingleChildWidget> dependentServices = [];

List<SingleChildWidget> viewProviders = [
  ChangeNotifierProvider<SpendingYear>(
    create: (_) => new SpendingYear(),
  ),
];
