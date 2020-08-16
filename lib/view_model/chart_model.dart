import 'dart:collection';

import 'package:Covid19/model/global.dart';
import 'package:Covid19/provider/view_state_model.dart';
import 'package:Covid19/service/covid_repository.dart';
import 'package:Covid19/utils/date_utils.dart';
import 'package:Covid19/widgets/filter_dropdown.dart';

class ChartModel extends ViewStateModel {
  int _filterType = kFilterPass7Days;
  int _filterStatus = kTotalConfirmed;
  List<Global> _globals = [];

  int get filterType => _filterType;
  int get filterStatus => _filterStatus;

  List<Global> get globals => UnmodifiableListView(_globals);

  set filterType(int value) {
    if (value == _filterType) return;
    _filterType = value;
    loadData();
    notifyListeners();
  }

  set filterStatus(int value) {
    if (value == _filterStatus) return;
    _filterStatus = value;
    notifyListeners();
  }

  loadData() async {
    try {
      setBusy();
      List<DateTime> dates = DateUtils.getDateRangeByFilter(_filterType);
      _globals =
          await CovidRepository.getNewcasesByDateRange(dates[0], dates[1]);
          print("fetch xxx");
      setIdle();
      // notifyListeners();
    } catch (error, s) {
      setError(error, s);
    }
  }
}
