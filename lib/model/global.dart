class Global {
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  Global.fromJsonMap(Map<String, dynamic> map)
      : newConfirmed = map["NewConfirmed"],
        totalConfirmed = map["TotalConfirmed"],
        newDeaths = map["NewDeaths"],
        totalDeaths = map["TotalDeaths"],
        newRecovered = map["NewRecovered"],
        totalRecovered = map["TotalRecovered"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NewConfirmed'] = newConfirmed;
    data['TotalConfirmed'] = totalConfirmed;
    data['NewDeaths'] = newDeaths;
    data['TotalDeaths'] = totalDeaths;
    data['NewRecovered'] = newRecovered;
    data['TotalRecovered'] = totalRecovered;

    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
