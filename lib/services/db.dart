import 'package:budget_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './globals.dart';

class TransactionsService {
  final Firestore _db = Firestore.instance;
  final String path = '/transactions';
  CollectionReference ref;

  TransactionsService() {
    ref = _db.collection(path);
  }
  // TODO is this the right way to handle the data.
  Stream<List<TransactionRec>> streamTransactionPerYear(
      FirebaseUser user, int year) {
    if (user != null) {
      var stream = ref
          .where('uid', isEqualTo: user.uid)
          .where('date', isGreaterThan: new DateTime.utc(year - 1))
          .where('date', isLessThan: new DateTime.utc(year + 1))
          .snapshots();
      return stream.map((list) {
        return list.documents
            .map((doc) =>
                Global.models[TransactionRec](doc.documentID, doc.data)
                    as TransactionRec)
            .toList();
      });
    }
  }

  Stream<List<TransactionRec>> streamTransactionsPerMonth(
      FirebaseUser user, int year, int month) {
    if (user != null) {
      var stream = ref
          .where('uid', isEqualTo: user.uid)
          .where('date', isGreaterThan: new DateTime.utc(year, month, 0))
          .where('date', isLessThan: new DateTime.utc(year, month + 1, 0))
          .snapshots();
      return stream.map((list) => list.documents
          .map((doc) => Global.models[TransactionRec](doc.documentID, doc.data)
              as TransactionRec)
          .toList());
    }
  }

  Future deleteTransaction(String id) {
    return ref.document(id).delete();
  }

  Future addTransaction(FirebaseUser user, TransactionRec transaction) {
    return ref.add({
      "name": transaction.name,
      "uid": user.uid,
      "category": transaction.category,
      "amount": transaction.amount,
      "date": transaction.date
    });
  }
}
