import 'package:flutter/material.dart';

const kFilterPass7Days = 1;
const kFilterPass30Days = 2;
const kFilterPass90Days = 3;
const kFilterAllTime = 4;

const kTotalConfirmed = 1;
const kTotalRecovered = 2;
const kTotalDeath = 3;

class FilterDropdown extends StatelessWidget {
  final int value;
  final Function(int value) onFilterChanged;
  final List<FilterItem> items;

  FilterDropdown({this.value, this.onFilterChanged, this.items});

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: Theme.of(context).textTheme.bodyText1,
      underline: Container(),
      value: value,
      items: items
          .map((e) => DropdownMenuItem(
                child: Text(e.label),
                value: e.value,
              ))
          .toList(),
      onChanged: onFilterChanged,
    );
  }
}

class FilterItem {
  final int value;
  final String label;

  FilterItem(this.value, this.label);
}

class FilterValues {
  static List<FilterItem> getFilterValues() {
    return [
      FilterItem(kFilterPass7Days, "Past 7 days"),
      FilterItem(kFilterPass30Days, "Pass 30 days"),
      FilterItem(kFilterPass90Days, "Pass 90 days"),
      FilterItem(kFilterAllTime, "All time"),
    ];
  }

  static List<FilterItem> getFilterValuesByType() {
    return [
      FilterItem(kTotalConfirmed, "Total Confirmed"),
      FilterItem(kTotalRecovered, "Total Recovered"),
      FilterItem(kTotalDeath, "Total Death"),
    ];
  }

  static List<FilterItem> getCountries() {
    return [
      FilterItem(1, "View Nam"),
      FilterItem(kTotalRecovered, "American"),
      FilterItem(kTotalDeath, "Russian"),
    ];
  }
}
