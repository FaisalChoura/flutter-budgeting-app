import 'package:budget_app/providers/providers.dart';
import 'package:budget_app/services/db.dart';
import 'package:budget_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearViewScreen extends StatelessWidget {
  final TransactionsService transactionsService = TransactionsService();

  @override
  Widget build(BuildContext context) {
    SpendingYear spendingYear = Provider.of<SpendingYear>(context);
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    return StreamBuilder(
      stream:
          transactionsService.streamTransactionPerYear(user, spendingYear.year),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Loading'),
          );
        }
        spendingYear.buildMonthsList(snap.data);
        return ChangeNotifierProvider<YearViewProvider>(
          create: (_) => YearViewProvider(),
          child: Consumer<YearViewProvider>(
            builder: (context, yearViewState, child) => Scaffold(
              appBar: YearViewAppBar(year: spendingYear.year.toString()),
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
                      child: AnimatedTotalSpendings(
                        year: spendingYear,
                      )),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.fastOutSlowIn,
                    height: yearViewState.height == 0.0
                        ? MediaQuery.of(context).size.height * .7
                        : yearViewState.height,
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
                        itemCount: spendingYear.months.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: MonthCard(
                              month: spendingYear.months[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              extendBodyBehindAppBar: true,
              extendBody: true,
            ),
          ),
        );
      },
    );
  }
}

class AnimatedTotalSpendings extends StatelessWidget {
  SpendingYear year;
  AnimatedTotalSpendings({@required this.year});

  @override
  Widget build(BuildContext context) {
    return Consumer<YearViewProvider>(
      builder: (context, yearViewState, child) => AnimatedContainer(
        duration: Duration(milliseconds: 3),
        padding: EdgeInsets.only(top: yearViewState.budgetColPadding),
        child: Column(
          children: <Widget>[
            // TODO this is similar in month can we extract?
            AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: yearViewState.budgetFontSize,
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
                year.totalSpending.toStringAsFixed(2),
              ),
            ),
            Text(
              'Total Spendings',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 350),
              child: SizedBox(
                  height: 200,
                  width: 400,
                  child: YearChart(spendingYear: year)),
              opacity: yearViewState.visible ? 1.0 : 0,
            )
          ],
        ),
      ),
    );
  }
}

class YearViewAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  YearViewAppBar({
    Key key,
    @required this.year,
  }) : super(key: key);

  final String year;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        year,
        style: TextStyle(fontSize: 24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        FlatButton(
          onPressed: () => _toggleChart(context),
          child: Icon(
            Icons.show_chart,
            color: Colors.white,
            size: 28,
          ),
        )
      ],
    );
  }

  _toggleChart(context) {
    {
      var yearViewState = Provider.of<YearViewProvider>(context, listen: false);
      var height = yearViewState.height;
      var newHeight = height == MediaQuery.of(context).size.height * .5
          ? MediaQuery.of(context).size.height * .7
          : MediaQuery.of(context).size.height * .5;
      yearViewState.height = newHeight;
      yearViewState.visible = !yearViewState.visible;
      yearViewState.budgetFontSize =
          yearViewState.budgetFontSize == 48 ? 32 : 48;
      yearViewState.budgetColPadding =
          yearViewState.budgetColPadding == 130 ? 110 : 130;
    }
  }
}
