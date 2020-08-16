class Country {
  String name;
  String code;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  String date;

  Country.fromJsonMap(Map<String, dynamic> map)
      : name = map["Country"],
        code = map["CountryCode"],
        newConfirmed = map["NewConfirmed"],
        totalConfirmed = map["TotalConfirmed"],
        newDeaths = map["NewDeaths"],
        totalDeaths = map["TotalDeaths"],
        newRecovered = map["NewRecovered"],
        totalRecovered = map["TotalRecovered"],
        date = map["Date"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Country'] = name;
    data['CountryCode'] = code;
    data['NewConfirmed'] = newConfirmed;
    data['TotalConfirmed'] = totalConfirmed;
    data['NewDeaths'] = newDeaths;
    data['TotalDeaths'] = totalDeaths;
    data['NewRecovered'] = newRecovered;
    data['TotalRecovered'] = totalRecovered;
    data['Date'] = date;

    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
