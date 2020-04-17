import 'package:flutter/foundation.dart';

class SelectedYear extends ChangeNotifier {
  int _year = DateTime.now().year;

  int get year => _year;
  set year(int year) {
    this._year = year;
    notifyListeners();
  }
}
