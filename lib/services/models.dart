import 'package:cloud_firestore/cloud_firestore.dart';

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

class BTransaction {
  // String id;
  String name;
  double amount;
  String category;
  Timestamp date;

  BTransaction({this.name, this.amount, this.category, this.date});

  factory BTransaction.fromMap(Map data) {
    return BTransaction(
      name: data['name'] ?? '',
      amount: data['amount'] ?? 0,
      category: data['category'] ?? '',
      date: data['date'] ?? Timestamp.now(),
    );
  }
}
