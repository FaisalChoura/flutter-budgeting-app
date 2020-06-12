import 'package:budget_app/models/models.dart';
import 'package:budget_app/screens/screens.dart';
import 'package:flutter/material.dart';

class MonthCard extends StatelessWidget {
  final Month month;

  MonthCard({
    Key key,
    this.month,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: Color.fromARGB(70, 0, 0, 0),
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(60, 0, 0, 0),
              offset: Offset(1, 3),
              blurRadius: 10.0),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MonthTransactionsScreen(
                  monthName: this.month.name,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  month.name,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '£ ${month.amount}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
