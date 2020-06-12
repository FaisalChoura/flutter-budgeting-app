import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class YearScreenProvider extends ChangeNotifier {
  // bool busy = false;

  num _monthDataContainerheight = 0.0;

  bool _visible = false;

  // Total Spendings vars
  double _totalSpendingsFontSize = 48;
  double _totalSpendingsPadding = 130;

  get monthDataContainerheight => _monthDataContainerheight;
  get yearChartVisible => _visible;
  get totalSpendingsFontSize => _totalSpendingsFontSize;
  get totalSpendingsPadding => _totalSpendingsPadding;

  set monthDataContainerheight(double h) {
    _monthDataContainerheight = h;
    notifyListeners();
  }

  /// triggers the visibility of the year chart
  set yearChartVisible(bool v) {
    _visible = v;
    notifyListeners();
  }

  set totalSpendingsFontSize(double fontsize) {
    _totalSpendingsFontSize = fontsize;
    notifyListeners();
  }

  set totalSpendingsPadding(double padding) {
    _totalSpendingsPadding = padding;
    notifyListeners();
  }

  toggleChart(num mediaHeight) {
    {
      var height = this.monthDataContainerheight;
      var newHeight =
          height == mediaHeight * .5 ? mediaHeight * .7 : mediaHeight * .5;
      monthDataContainerheight = newHeight;
      yearChartVisible = !yearChartVisible;
      totalSpendingsFontSize = totalSpendingsFontSize == 48 ? 32 : 48;
      totalSpendingsPadding = totalSpendingsPadding == 130 ? 110 : 130;
    }
  }
}
