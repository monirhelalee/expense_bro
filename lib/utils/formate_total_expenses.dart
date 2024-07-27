import 'package:intl/intl.dart';

String formatTotalExpenses(double totalExpenses) {
  final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
  final formatedValue = currency.format(totalExpenses.abs());
  return totalExpenses <= 0 ? formatedValue : '-$formatedValue';
}
