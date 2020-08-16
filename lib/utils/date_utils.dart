import 'package:Covid19/widgets/filter_dropdown.dart';
import 'package:intl/intl.dart';

class DateUtils {
  static List<DateTime> getDateRangeByFilter(int filter) {
    DateTime now = DateTime.now();
    DateTime nowUtc = DateTime.utc(now.year, now.month, now.day);
    DateTime startUtc = DateTime.utc(2020, 1, 22);
    switch (filter) {
      case kFilterPass7Days:
        return [nowUtc.subtract(Duration(days: 7)), nowUtc]; // [from, to]
      case kFilterPass30Days:
        return [nowUtc.subtract(Duration(days: 30)), nowUtc]; // [from, to]
      case kFilterPass90Days:
        return [nowUtc.subtract(Duration(days: 90)), nowUtc]; // [from, to]
      default:
        return [startUtc, nowUtc]; // [from, to]
    }
  }

  static String formatChartDate(DateTime date) {
    final formater = new DateFormat('dd/MM/yyyy');
    return formater.format(date);
  }
}
