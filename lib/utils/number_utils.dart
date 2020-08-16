import 'package:intl/intl.dart';

class NumberUtils {
  static String formatNumber(int number) {
    final formatter = NumberFormat("#,###");
    return formatter.format(number);
  }

  static String formatNumberCompat(int number) {
    final formatter = NumberFormat.compact();
    return formatter.format(number);
  }
}
