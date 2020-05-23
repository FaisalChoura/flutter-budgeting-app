import 'package:budget_app/models/models.dart';
import 'package:budget_app/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class YearChart extends StatelessWidget {
  // final List<charts.Series> seriesList;
  final SpendingYear spendingYear;

  YearChart({@required this.spendingYear});

  @override
  Widget build(BuildContext context) {
    final data = spendingYear.months;

    int year = Provider.of<SpendingYear>(context).year;
    List<charts.Series<Month, DateTime>> series = [
      charts.Series(
        id: "yearlyTransactions",
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.white,
        domainFn: (Month month, _) => DateTime.utc(year, month.number),
        measureFn: (Month month, _) => month.amount,
      )
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(16),
      child: SizedBox(
        child: charts.TimeSeriesChart(
          series,
          animate: true,
          domainAxis: new charts.DateTimeAxisSpec(
            tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
              month: charts.TimeFormatterSpec(
                  format: 'MMM', transitionFormat: 'MMM'),
            ),
            renderSpec: new charts.SmallTickRendererSpec(
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.white),
              axisLineStyle: charts.LineStyleSpec(
                color: charts.MaterialPalette.white,
              ),
            ),
          ),
          primaryMeasureAxis: new charts.NumericAxisSpec(
              renderSpec: new charts.NoneRenderSpec()
              //   new charts.GridlineRendererSpec(
              //   labelStyle: new charts.TextStyleSpec(
              //       fontSize: 14, // size in Pts.
              //       color: charts.MaterialPalette.white),
              //   lineStyle:
              //       new charts.LineStyleSpec(color: charts.MaterialPalette.white),
              // ),
              ),
        ),
      ),
    );
  }
}
