import 'package:Covid19/model/country.dart';
import 'package:Covid19/utils/number_utils.dart';
import 'package:flutter/material.dart';

class CountryRow extends StatelessWidget {
  final Country country;
  final int index;

  CountryRow({this.country, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.redAccent,
            child: Text(
              index.toString(),
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white),
            ),
          ),
          SizedBox(width: 8.0),
          Image.asset(
            "assets/flags/${country.code.toLowerCase()}.png",
            width: 32,
            height: 32,
          ),
          SizedBox(width: 12.0),
          Expanded(
              child: Text(
            country.name,
            style: Theme.of(context).textTheme.bodyText1,
          )),
          SizedBox(width: 8.0),
          Text(
            NumberUtils.formatNumber(country.totalConfirmed),
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
