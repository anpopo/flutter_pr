import 'package:intl/intl.dart';
final _formatter = DateFormat.yMd();

class DateFormatter {
  static String format(DateTime date) {
    return _formatter.format(date);
  }
}