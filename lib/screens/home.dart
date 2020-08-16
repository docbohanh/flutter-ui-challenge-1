import 'package:Covid19/commons/colors.dart';
import 'package:Covid19/model/country.dart';
import 'package:Covid19/model/global.dart';
import 'package:Covid19/provider/provider_widget.dart';
import 'package:Covid19/utils/date_utils.dart';
import 'package:Covid19/utils/number_utils.dart';
import 'package:Covid19/view_model/chart_model.dart';
import 'package:Covid19/view_model/summary_model.dart';
import 'package:Covid19/widgets/chart_stats.dart';
import 'package:Covid19/widgets/country_row.dart';
import 'package:Covid19/widgets/filter_dropdown.dart';
import 'package:Covid19/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SummaryModel _summaryModel;

  @override
  void initState() {
    _summaryModel = SummaryModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kBackgroundColor),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Statistics",
            style: TextStyle(
                color: Color(kTextColor), fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: ProviderWidget<SummaryModel>(
                    model: _summaryModel,
                    onModelReady: (model) => model.loadData(),
                    builder: (context, model, child) {
                      if (model.isBusy) {
                        return SkeletonSummaryCard();
                      }
                      Global global = model.global;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Total cases: ${NumberUtils.formatNumber(global.totalConfirmed)}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  FilterDropdown(
                                      items: FilterValues.getFilterValues(),
                                      value: 1,
                                      onFilterChanged: (value) {}),
                                  SizedBox(height: 4.0),
                                  Text(
                                      "Last update: ${DateUtils.formatChartDate(DateTime.now())}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              fontStyle: FontStyle.italic))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 8.0,
                                        height: 8.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF498ED0)),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text("Recovered",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    "${NumberUtils.formatNumber(global.totalRecovered)}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 8.0,
                                        height: 8.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFF0283D)),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text("New cases",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    "${NumberUtils.formatNumber(global.newConfirmed)}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 8.0,
                                        height: 8.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF5B0611)),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text("Death",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1)
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    "${NumberUtils.formatNumber(global.totalDeaths)}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      );
                    }),
              ),
            ),
            chart,
            topCountries,
          ],
        ),
      ),
    );
  }

  Widget get chart => Card(
        margin: EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: ProviderWidget<ChartModel>(
              onModelReady: (model) => model.loadData(),
              builder: (context, model, child) {
                List<Widget> children;
                if (model.isBusy) {
                  children = [SkeletonChart()];
                } else if (model.isError) {
                  children = [Text("error")];
                } else {
                  children = [
                    ChartStats(
                      globals: model.globals,
                      filterType: model.filterType,
                      filterStatus: model.filterStatus,
                    ),
                  ];
                }

                return Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FilterDropdown(
                            items: FilterValues.getFilterValuesByType(),
                            value: model.filterStatus,
                            onFilterChanged: (value) {
                              model.filterStatus = value;
                            }),
                        FilterDropdown(
                            items: FilterValues.getFilterValues(),
                            value: model.filterType,
                            onFilterChanged: (value) {
                              model.filterType = value;
                            }),
                      ],
                    ),
                    ...children,
                  ],
                );
              },
              model: ChartModel()),
        ),
      );

  Widget get topCountries => Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Top countries",
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 4.0),
                Text(
                    "Last update: ${DateUtils.formatChartDate(DateTime.now())}",
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontStyle: FontStyle.italic)),
                SizedBox(height: 8.0),
                ProviderWidget<SummaryModel>(
                  builder: (_, model, __) {
                    if (model.isBusy) {
                      return SkeletonCountriesList();
                    } else {
                      List<Country> countries = model.getTopCountries();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: countries.length,
                        itemBuilder: (context, index) {
                          return CountryRow(
                              country: countries[index], index: index + 1);
                        },
                      );
                    }
                  },
                  model: _summaryModel,
                ),
              ],
            )),
      );
}
