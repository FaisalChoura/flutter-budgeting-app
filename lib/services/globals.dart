import 'package:budget_app/models/models.dart';

class Global {
  static final String title = 'Budget App';

  static final Map models = {
    TransactionRec: (id, data) => TransactionRec.fromMap(id, data),
  };
}
