import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptController with ChangeNotifier {
  double fixedRateValue = 8.0;

  String toCurrency(double value) =>
      NumberFormat.simpleCurrency(locale: 'pt-BR').format(value);
}
