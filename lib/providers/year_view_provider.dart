import 'package:flutter/foundation.dart';

class YearViewProvider extends ChangeNotifier {
  double _height = 0.0;
  bool _visible = false;
  double _budgetFontSize = 48;
  double _budgetColPadding = 130;

  get height => _height;
  get visible => _visible;
  get budgetFontSize => _budgetFontSize;
  get budgetColPadding => _budgetColPadding;

  set height(double h) {
    _height = h;
    notifyListeners();
  }

  set visible(bool v) {
    _visible = v;
    notifyListeners();
  }

  set budgetFontSize(double fontsize) {
    _budgetFontSize = fontsize;
    notifyListeners();
  }

  set budgetColPadding(double padding) {
    _budgetColPadding = padding;
    notifyListeners();
  }
}
