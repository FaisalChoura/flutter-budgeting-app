import 'package:budget_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("TransactionRec", () {
    test("factory constructor", () {
      final timestamp = Timestamp.now();
      final data = Map();
      data["name"] = "KFC";
      data["amount"] = 13.4;
      data["date"] = timestamp;
      data["category"] = "Eating Out";

      final transactionRec = TransactionRec.fromMap("123456", data);
      expect(transactionRec.name, "KFC");
      expect(transactionRec.amount, 13.4);
      expect(transactionRec.date, timestamp);
      expect(transactionRec.category, "Eating Out");
    });
  });
}
