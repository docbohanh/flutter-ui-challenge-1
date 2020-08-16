import 'package:Covid19/model/global.dart';
import 'package:Covid19/utils/date_utils.dart';
import 'package:Covid19/utils/number_utils.dart';
import 'package:Covid19/widgets/filter_dropdown.dart';

class ChartUtils {
  static double getMaxYaxis(List<Global> globals, int filterStatus) {
    Global maxCases = globals.reduce((current, next) {
      if (filterStatus == kTotalConfirmed) {
        return current.totalConfirmed > next.totalConfirmed ? current : next;
      } else if (filterStatus == kTotalRecovered) {
        return current.totalRecovered > next.totalRecovered ? current : next;
      }
      return current.totalDeaths > next.totalDeaths ? current : next;
    });
    int maxValue;
    if (filterStatus == kTotalConfirmed) {
      maxValue = maxCases.totalConfirmed;
    } else if (filterStatus == kTotalRecovered) {
      maxValue = maxCases.totalRecovered;
    } else {
      maxValue = maxCases.totalDeaths;
    }

    return (maxValue * 1.5).toDouble();
  }

  static String getXaxisTitles(double value, int filterType) {
    List<DateTime> dates = DateUtils.getDateRangeByFilter(filterType);
    List<String> titles = [];
    DateTime temp = dates[0];
    while (temp.isBefore(dates[1])) {
      titles.add(DateUtils.formatChartDate(temp));
      temp = temp.add(Duration(days: 1));
    }
    int intValue = value.toInt();
    return titles.length > intValue ? titles[value.toInt()] : '';
  }

  static String getYaxisTitles(double value, int filterStatus) {
    int factor;
    switch (filterStatus) {
      case kTotalConfirmed:
        factor = 4000000;
        break;
      case kTotalRecovered:
        factor = 4000000;
        break;
      case kTotalDeath:
        factor = 200000;
        break;
    }
    int intValue = value.toInt();
    return intValue % factor == 0 && intValue > 0
        ? NumberUtils.formatNumberCompat(intValue)
        : '';
  }

  static double getXaxisInterval(int filterType) {
    switch (filterType) {
      case kFilterPass7Days:
        return 1.0;
      case kFilterPass30Days:
        return 3.0;
      case kFilterPass90Days:
        return 10.0;
      default:
        return 10.0;
    }
  }
}
