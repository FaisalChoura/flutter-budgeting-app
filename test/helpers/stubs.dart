import 'package:budget_app/models/models.dart';
import 'package:budget_app/providers/providers.dart';
import 'package:budget_app/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'constants.dart';
import 'mocks.dart';

void stubUserId(FirebaseUserMock mockedUser) {
  when(mockedUser.uid).thenReturn("userid1234");
}

void stubTransactionsPerYear(TransactionsService transactionsService,
    FirebaseUserMock mockedUser, num year) {
  when(transactionsService.streamTransactionPerYear(mockedUser, year))
      .thenAnswer(
    (_) {
      return Stream<List<TransactionRec>>.value(
          [eatingOut1, eatingOut2, shopping]);
    },
  );
}

void stubTransactionsPerMonth(TransactionsService transactionsService,
    FirebaseUserMock mockedUser, num year, int month) {
  when(transactionsService.streamTransactionsPerMonth(mockedUser, year, month))
      .thenAnswer(
    (_) {
      return Stream<List<TransactionRec>>.value(
          [eatingOut1, eatingOut2, shopping]);
    },
  );
}

void stubDeletedTransactionsPerMonth(TransactionsService transactionsService,
    FirebaseUserMock mockedUser, num year, int month) {
  when(transactionsService.streamTransactionsPerMonth(mockedUser, year, month))
      .thenAnswer(
    (_) {
      return Stream<List<TransactionRec>>.value([eatingOut2, shopping]);
    },
  );
}

void stubAddTransaction(
    TransactionsService transactionsService, FirebaseUserMock mockedUser) {
  when(transactionsService.addTransaction(
          mockedUser, argThat(isA<TransactionRec>())))
      .thenAnswer(
    (_) {
      return Future.value();
    },
  );
}

List<SingleChildWidget> providersWithStubbedValues(
  TransactionsService transactionsService,
  FirebaseUserMock mockedUser,
) {
  return [
    Provider<FirebaseUser>.value(
      value: mockedUser,
    ),
    Provider<TransactionsService>.value(
      value: transactionsService,
    ),
    ChangeNotifierProvider<SpendingYear>(
      create: (_) => new SpendingYear(),
    ),
  ];
}
