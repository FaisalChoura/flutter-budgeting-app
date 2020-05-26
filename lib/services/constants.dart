import 'package:charts_flutter/flutter.dart';

List<String> monthsOfTheYear = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

List<String> daysOfTheWeek = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

Map<String, int> categoryNumbers = {
  "Shopping": 1, // Blue
  "Eating Out": 2, // Red
  "Groceries": 3, // Yellow
  "Leasure": 4, // Green
  "Travelling": 5, // Orange
  "Other": 0
};

Map<String, Color> categoryColors = {
  "Shopping": Color(r: 89, g: 216, b: 255), // Blue
  "Eating Out": Color(r: 255, g: 89, b: 100), // Red
  "Groceries": Color(r: 255, g: 249, b: 89), // Yellow
  "Leasure": Color(r: 89, g: 255, b: 89), // Green
  "Travelling": Color(r: 255, g: 166, b: 89), // Orange
  "Other": Color(r: 255, g: 255, b: 255)
};
