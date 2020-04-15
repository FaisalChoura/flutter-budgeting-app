import 'package:budget_app/services/models.dart';
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

  Stream<List<BTransaction>> streamTransactionPerYear(
      FirebaseUser user, int year) {
    var stream = ref
        .where('uid', isEqualTo: user.uid)
        .where('date', isGreaterThan: new DateTime.utc(year - 1))
        .where('date', isLessThan: new DateTime.utc(year + 1))
        .snapshots();
    return stream.map((list) => list.documents
        .map((doc) => Global.models[BTransaction](doc.data) as BTransaction)
        .toList());
  }
}
