import 'package:budget_app/services/auth.dart';
import 'package:budget_app/services/helpers.dart';
import 'package:budget_app/services/models.dart';
import 'package:budget_app/services/db.dart';
import 'package:budget_app/widgets/month_card.dart';
import 'package:budget_app/widgets/year_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearViewScreen extends StatelessWidget {
  final TransactionsService transactionsService = TransactionsService();

  YearViewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return StreamProvider<List<BTransaction>>.value(
      value: transactionsService.streamTransactionPerYear(user, 2020),
      child: YearViewUI(),
    );
  }
}

class YearViewUI extends StatefulWidget {
  YearViewUI({Key key}) : super(key: key);

  @override
  _YearViewUIState createState() => _YearViewUIState();
}

class _YearViewUIState extends State<YearViewUI> {
  double _height = 0.0;
  bool _visible = false;
  double budgetFontSize = 48;
  double budgetColPadding = 130;

  List<Month> months;

  String year = '2019';

  @override
  Widget build(BuildContext context) {
    months = buildMonthsList(Provider.of<List<BTransaction>>(context));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          year,
          style: TextStyle(fontSize: 24),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          FlatButton(
            onPressed: _toggleChart,
            child: Icon(
              Icons.show_chart,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 31, 109, 255),
                  Color.fromARGB(255, 31, 184, 255),
                ],
                begin: new Alignment(0.0, -0.5),
                end: Alignment.topCenter,
              ),
            ),
            // alignment: new Alignment(0.0, -0.65),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 3),
              padding: EdgeInsets.only(top: budgetColPadding),
              child: Column(
                children: <Widget>[
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: budgetFontSize,
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
                      '15,200',
                    ),
                  ),
                  Text(
                    'Total Spendings',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 350),
                    child: YearChart(),
                    opacity: _visible ? 1.0 : 0,
                  )
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 350),
            curve: Curves.fastOutSlowIn,
            height: _height == 0.0
                ? MediaQuery.of(context).size.height * .7
                : _height,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(60, 0, 0, 0),
                    offset: Offset(0, -3),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: months.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: MonthCard(month: months[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }

  _toggleChart() {
    setState(() {
      _height = _height == MediaQuery.of(context).size.height * .5
          ? MediaQuery.of(context).size.height * .7
          : MediaQuery.of(context).size.height * .5;
      _visible = !_visible;
      budgetFontSize = budgetFontSize == 48 ? 32 : 48;
      budgetColPadding = budgetColPadding == 130 ? 110 : 130;
    });
  }
}
