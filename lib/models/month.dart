import 'package:budget_app/models/models.dart';
import 'package:budget_app/services/helpers.dart';

class Month {
  String name;
  double amount = 0;
  int number;
  List<TransactionRec> transactions = [];

  Month({this.name}) {
    // TODO check if we can make this cleaner
    number = monthNameToNumber(name);
  }

  void addTransactions(List<TransactionRec> transactions) {
    transactions.forEach((element) {
      addTransaction(element);
    });
  }

  void addTransaction(TransactionRec transaction) {
    this.amount = this.amount + transaction.amount;
    this.transactions.add(transaction);
  }
}
