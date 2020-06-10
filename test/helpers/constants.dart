import 'package:budget_app/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final date = new DateTime.utc(2020, 11, 20);

final eatingOut1 = TransactionRec(
    id: "1",
    name: "KFC",
    amount: 25,
    category: "Eating Out",
    date: Timestamp.now());
final eatingOut2 = TransactionRec(
    id: "2",
    name: "Poke",
    amount: 15,
    category: "Eating Out",
    date: Timestamp.now());
final shopping = TransactionRec(
    id: "3",
    name: "H&M",
    amount: 30,
    category: "Shopping",
    date: Timestamp.now());
