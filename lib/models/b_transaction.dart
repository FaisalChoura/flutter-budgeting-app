import 'package:cloud_firestore/cloud_firestore.dart';

class BTransaction {
  String id;
  String name;
  double amount;
  String category;
  Timestamp date;

  BTransaction({this.id, this.name, this.amount, this.category, this.date});

  factory BTransaction.fromMap(String id, Map data) {
    return BTransaction(
      id: id,
      name: data['name'] ?? '',
      amount: data['amount'] ?? 0,
      category: data['category'] ?? '',
      date: data['date'] ?? Timestamp.now(),
    );
  }
}
