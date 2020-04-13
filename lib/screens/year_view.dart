import 'package:budget_app/services/auth.dart';
import 'package:budget_app/services/helpers.dart';
import 'package:budget_app/services/models.dart';
import 'package:budget_app/services/db.dart';
import 'package:budget_app/widgets/bottom_nav.dart';
import 'package:budget_app/widgets/month_card.dart';
import 'package:budget_app/widgets/year_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearViewScreen extends StatefulWidget {
  const YearViewScreen({Key key}) : super(key: key);

  @override
  _YearViewScreenState createState() => _YearViewScreenState();
}

class _YearViewScreenState extends State<YearViewScreen> {
  double _height = 0.0;
  bool _visible = false;
  double budgetFontSize = 48;
  double budgetColPadding = 130;

  AuthService auth = AuthService();
  List<Month> months = [];
  TransactionsService transactionsService;

  String year = '2019';

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    if (user != null) {
      transactionsService = TransactionsService(uid: user.uid);
    }

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
              child: FutureBuilder(
                future: transactionsService.transactionsByear(2020),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(
                        child: Text('Loading...'),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Container(
                      child: Center(
                        child: Text('Error...'),
                      ),
                    );
                  }
                  List<Month> months =
                      snapshot.hasData ? buildMonthsList(snapshot.data) : null;
                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: months.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: MonthCard(month: months[index]),
                      );
                    },
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
