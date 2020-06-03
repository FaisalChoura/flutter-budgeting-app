import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionRec {
  String id;
  String name;
  num amount;
  String category;
  Timestamp date;

  TransactionRec({this.id, this.name, this.amount, this.category, this.date});

  factory TransactionRec.fromMap(String id, Map data) {
    return TransactionRec(
      id: id,
      name: data['name'] ?? '',
      amount: data['amount'] ?? 0,
      category: data['category'] ?? '',
      date: data['date'] ?? Timestamp.now(),
    );
  }
}
