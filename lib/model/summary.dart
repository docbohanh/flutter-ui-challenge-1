import 'package:Covid19/model/country.dart';
import 'package:Covid19/model/global.dart';

class Summary {
  Global global;
  List<Country> countries;

  Summary.fromJsonMap(Map<String, dynamic> map)
      : global = Global.fromJsonMap(map['Global']),
        countries = (map['Countries'] as List)
            .map<Country>((item) => Country.fromJsonMap(item))
            .toList();
}
