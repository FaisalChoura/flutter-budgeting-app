import 'package:budget_app/models/models.dart';

class Month {
  String name;
  double amount = 0;
  List<BTransaction> transactions = [];

  Month({this.name});

  void addTransaction(BTransaction transaction) {
    this.amount = this.amount + transaction.amount;
    this.transactions.add(transaction);
  }
}
