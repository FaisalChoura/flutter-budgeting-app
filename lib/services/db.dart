import 'package:budget_app/services/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './globals.dart';

class TransactionsService {
  final Firestore _db = Firestore.instance;
  final String path = '/transactions';
  final String uid;
  CollectionReference ref;

  TransactionsService({this.uid}) {
    ref = _db.collection(path);
  }

  Future<List<BTransaction>> transactionsByear(int year) async {
    if (uid != null) {
      var snapshots = await ref
          .where('uid', isEqualTo: this.uid)
          .where('date', isGreaterThan: new DateTime.utc(year - 1))
          .where('date', isLessThan: new DateTime.utc(year + 1))
          .getDocuments();

      return snapshots.documents
          .map((doc) => Global.models[BTransaction](doc.data) as BTransaction)
          .toList();
    }
  }
}
