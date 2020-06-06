import 'package:budget_app/models/models.dart';
import 'package:budget_app/widgets/charts/month_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MonthHeader extends StatefulWidget {
  const MonthHeader({
    Key key,
    @required this.month,
  }) : super(key: key);

  final Month month;

  @override
  MonthHeaderState createState() => MonthHeaderState();
}

class MonthHeaderState extends State<MonthHeader>
    with TickerProviderStateMixin {
  bool _expanded = false;
  double _height;
  AnimationController turnController;

  get expanded => _expanded;
  get height => _height;

  initState() {
    turnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    super.initState();
  }

  @override
  void dispose() {
    turnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = _expanded
        ? MediaQuery.of(context).size.height * 0.48
        : MediaQuery.of(context).size.height * 0.25;

    return AnimatedContainer(
      key: Key("animtedMonthHeaderContainer"),
      duration: Duration(milliseconds: 250),
      curve: Curves.easeInCubic,
      // TODO check fragmantation for entire app
      height: _height,
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
      child: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.width,
            // alignment: new Alignment(0.0, 0.4),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: <Widget>[
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: AnimatedDefaultTextStyle(
                        child: Text(
                          '£ ',
                        ),
                        duration: Duration(milliseconds: 250),
                        style: TextStyle(
                            fontSize: _expanded ? 24 : 32, color: Colors.white),
                      ),
                    ),
                    AnimatedDefaultTextStyle(
                      curve: Curves.easeInCubic,
                      duration: Duration(milliseconds: 250),
                      style: TextStyle(
                        fontSize: _expanded ? 32 : 48,
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
                        widget.month.amount.toStringAsFixed(2),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        key: Key("expansionToggle"),
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          _toggleExpansion();
                        },
                        child: RotationTransition(
                          turns: Tween(begin: 0.0, end: 0.5)
                              .animate(turnController),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  'Total Spending',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                AnimatedOpacity(
                  key: Key("monthBreakdownChartOpacity"),
                  duration: Duration(milliseconds: 100),
                  child: SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    child: MonthChart(
                      month: widget.month,
                    ),
                  ),
                  opacity: _expanded ? 1.0 : 0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _toggleExpansion() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        turnController.forward();
      } else {
        turnController.reverse();
      }
    });
  }
}
