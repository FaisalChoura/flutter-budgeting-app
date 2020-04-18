import 'package:budget_app/models/models.dart';
import 'package:flutter/material.dart';

class MonthScreen extends StatelessWidget {
  final Month month;
  const MonthScreen({Key key, this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(month.name),
      ),
    );
  }
}
