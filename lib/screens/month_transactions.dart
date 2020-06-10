import 'package:budget_app/providers/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

import 'package:budget_app/services/constants.dart';
import 'package:budget_app/services/db.dart';
import 'package:budget_app/models/models.dart';
import 'package:budget_app/services/helpers.dart';
import 'package:budget_app/widgets/month_transactions_header.dart';

class MonthTransactionsScreen extends StatelessWidget {
  final String monthName;

  MonthTransactionsScreen({Key key, this.monthName}) : super(key: key);
  // TODO fix grouping by
  @override
  Widget build(BuildContext context) {
    final transactionsService = Provider.of<TransactionsService>(context);
    var user = Provider.of<FirebaseUser>(context);
    var year = Provider.of<SpendingYear>(context).year;
    return StreamBuilder(
        stream: transactionsService.streamTransactionsPerMonth(
            user, year, monthNameToNumber(monthName)),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading'),
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(monthName),
            ),
            body: Column(
              children: <Widget>[
                MonthHeader(month: generateMonth(snap.data)),
                Expanded(
                  child: GroupedListView(
                    padding: EdgeInsets.all(0),
                    elements: snap.data,
                    groupBy: (TransactionRec transaction) {
                      return _userFriendlyDate(transaction);
                    },
                    groupSeparatorBuilder: (String date) {
                      return Padding(
                        // TODO Theme
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          date,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                    itemBuilder: (context, TransactionRec transaction) =>
                        TransactionTile(
                      transaction: transaction,
                    ),
                    order: GroupedListOrder.ASC,
                  ),
                )
              ],
            ),
            extendBodyBehindAppBar: true,
            extendBody: true,
          );
        });
  }

  Month generateMonth(List<TransactionRec> transactions) {
    var month = new Month(name: this.monthName);
    month.addTransactions(transactions);
    return month;
  }

  String _userFriendlyDate(TransactionRec transaction) {
    var date = transaction.date.toDate();
    if (date.toUtc() == DateTime.now().toUtc()) {
      return 'Today';
    }
    String weekDayName = daysOfTheWeek[date.weekday];
    // ordinal work
    String suffix = 'th';
    int day = date.day;
    final int digit = day % 10;
    if ((digit > 0 && digit < 4) && (day < 11 || day > 13)) {
      suffix = <String>['st', 'nd', 'rd'][digit - 1];
    }
    return '$weekDayName $day$suffix';
  }
}

enum Settings { delete }

class TransactionTile extends StatelessWidget {
  final TransactionRec transaction;
  TransactionTile({
    @required this.transaction,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactionsService = Provider.of<TransactionsService>(context);
    return ListTile(
      leading: Icon(
        Icons.image,
        size: 24,
      ),
      subtitle: Text(transaction.category),
      title: Text(
        transaction.name,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: Wrap(
        spacing: 8,
        children: <Widget>[
          Text(
            '£ ' + transaction.amount.toString(),
            style: TextStyle(fontSize: 16),
          ),
          PopupMenuButton<Settings>(
            key: Key("${transaction.id}transactionPopupMenu"),
            child: Icon(Icons.more_vert),
            onSelected: (Settings selected) {
              transactionsService.deleteTransaction(transaction.id);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Settings>>[
              const PopupMenuItem(
                value: Settings.delete,
                child: Text("Delete"),
              )
            ],
          )
        ],
      ),
    );
  }
}
