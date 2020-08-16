import 'package:Covid19/model/country.dart';
import 'package:Covid19/model/global.dart';
import 'package:Covid19/model/summary.dart';
import 'package:Covid19/provider/view_state_model.dart';
import 'package:Covid19/service/covid_repository.dart';

class SummaryModel extends ViewStateModel {
  Summary _summary;

  Global get global => _summary.global;

  List<Country> getTopCountries() {
    List<Country> countries = _summary?.countries ?? [];
    countries.sort(
        (previous, next) => next.totalConfirmed - previous.totalConfirmed);
    return countries.length >= 3 ? countries.sublist(0, 5) : [];
  }

  loadData() async {
    try {
      setBusy();
      _summary = await CovidRepository.getSummary();
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
