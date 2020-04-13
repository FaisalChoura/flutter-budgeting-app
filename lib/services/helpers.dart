import 'models.dart';

List<String> monthsOfTheYear = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

List<Month> buildMonthsList(List<BTransaction> transactions) {
  Map<int, Month> monthsMap = {};
  transactions.forEach((transaction) {
    var monthNumber = transaction.date.toDate().month;
    if (monthsMap[monthNumber] == null) {
      String monthName = monthsOfTheYear[monthNumber - 1];
      monthsMap[monthNumber] =
          new Month(amount: transaction.amount, name: monthName);
    } else {
      monthsMap[monthNumber].addTransaction(transaction);
    }
  });
  return monthsMap.values.toList();
}
