import 'package:budget_app/models/models.dart';

class Month {
  String name;
  double amount;
  List<BTransaction> transactions = [];

  Month({this.name, this.amount});

  void addTransaction(BTransaction transaction) {
    this.amount = this.amount + transaction.amount;
    this.transactions.add(transaction);
  }
}
