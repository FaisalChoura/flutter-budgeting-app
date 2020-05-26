import 'package:budget_app/models/models.dart';
import 'package:budget_app/services/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MonthChart extends StatelessWidget {
  final Month month;

  MonthChart({@required this.month});

  @override
  Widget build(BuildContext context) {
    var data = month.groupByCategory();

    List<charts.Series<Category, String>> series = [
      charts.Series<Category, String>(
          id: 'monthlyTransactions',
          domainFn: (Category category, _) => category.name,
          measureFn: (Category category, _) => category.total,
          data: data,
          colorFn: (Category category, _) {
            if (categoryColors[category.name] != null) {
              return categoryColors[category.name];
            }
            return charts.MaterialPalette.white;
          })
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        child: charts.PieChart(
          series,
          defaultRenderer: new charts.ArcRendererConfig(arcWidth: 10),
          behaviors: [
            new charts.DatumLegend(
                position: charts.BehaviorPosition.inside,
                desiredMaxColumns: 1,
                horizontalFirst: true,
                entryTextStyle: charts.TextStyleSpec(color: charts.Color.white))
          ],
        ),
      ),
    );
  }
}
