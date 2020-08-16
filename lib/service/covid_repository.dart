import 'package:Covid19/model/global.dart';
import 'package:Covid19/model/summary.dart';
import 'package:Covid19/service/net/covid_api.dart';

class CovidRepository {
  static Future<Summary> getSummary() async {
    var response = await http.get('summary');
    return Summary.fromJsonMap(response.data);
  }

  static Future<List<Global>> getNewcasesByDateRange(
      DateTime from, DateTime to) async {
    var response = await http
        .get('world?from=${from.toIso8601String()}&to=${to.toIso8601String()}');
    return (response.data as List).map((e) => Global.fromJsonMap(e)).toList();
  }
}
