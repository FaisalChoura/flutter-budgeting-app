import 'package:budget_app/models/models.dart';
import 'package:budget_app/services/helpers.dart';

class Month {
  String name;
  double amount = 0;
  int number;
  List<TransactionRec> transactions = [];

  Month({this.name}) {
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

  List<Category> groupByCategory() {
    Map<String, num> map = {};

    this.transactions.forEach((transaction) {
      if (map[transaction.category] != null) {
        map[transaction.category] =
            map[transaction.category] + transaction.amount;
      } else {
        map[transaction.category] = transaction.amount;
      }
    });

    List<Category> categories = [];

    map.forEach((key, value) {
      categories.add(new Category(name: key, total: value));
    });

    return categories;
  }
}
