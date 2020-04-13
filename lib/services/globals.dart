import 'package:budget_app/services/models.dart';

class Global {
  static final String title = 'Budget App';

  static final Map models = {
    BTransaction: (data) => BTransaction.fromMap(data),
  };
}
