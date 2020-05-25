import 'package:budget_app/models/models.dart';

class Month {
  String name;
  double amount = 0;
  int number;
  List<TransactionRec> transactions = [];

  Month({this.name}) {
    // TODO check if we can make this cleaner
    number = _nameToNumber(name);
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

  int _nameToNumber(String monthName) {
    Map<String, int> nameToNumberMap = {
      "January": 1,
      "February": 2,
      "March": 3,
      "April": 4,
      "May": 5,
      "June": 6,
      "July": 7,
      "August": 8,
      "September": 9,
      "October": 10,
      "November": 11,
      "December": 12,
    };
    return nameToNumberMap[monthName];
  }
}
