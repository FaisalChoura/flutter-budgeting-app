import 'package:budget_app/models/models.dart';

class Global {
  static final String title = 'Budget App';

  static final Map models = {
    BTransaction: (id, data) => BTransaction.fromMap(id, data),
  };
}
