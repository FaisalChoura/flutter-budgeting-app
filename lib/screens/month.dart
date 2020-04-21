import 'package:budget_app/models/models.dart';
import 'package:budget_app/services/helpers.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class MonthScreen extends StatelessWidget {
  final Month month;
  const MonthScreen({Key key, this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(month.name),
      ),
      body: Column(
        children: <Widget>[
          Container(
            // TODO check fragmantation for entire app
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 31, 109, 255),
                  Color.fromARGB(255, 31, 184, 255),
                ],
                begin: new Alignment(0.0, 0.35),
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(60, 0, 0, 0),
                  offset: Offset(0, 3),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Align(
              alignment: new Alignment(0.0, 0.3),
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 250),
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(60, 0, 0, 0),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Text(
                  month.amount.toStringAsFixed(2),
                ),
              ),
            ),
          ),
          Expanded(
            child: GroupedListView(
              padding: EdgeInsets.all(0),
              elements: month.transactions,
              groupBy: (BTransaction transaction) => transaction.date.toDate(),
              groupSeparatorBuilder: (DateTime date) {
                return Padding(
                  // TODO Theme
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    _userFriendlyDate(date),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              },
              itemBuilder: (context, BTransaction transaction) => ListTile(
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
                    Icon(Icons.more_vert),
                  ],
                ),
              ),
              order: GroupedListOrder.ASC,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }

  String _userFriendlyDate(DateTime date) {
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
