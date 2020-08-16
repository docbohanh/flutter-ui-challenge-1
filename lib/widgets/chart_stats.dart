import 'package:Covid19/commons/colors.dart';
import 'package:Covid19/model/global.dart';
import 'package:Covid19/utils/chart_utils.dart';
import 'package:Covid19/utils/number_utils.dart';
import 'package:Covid19/widgets/filter_dropdown.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartStats extends StatelessWidget {
  final List<Global> globals;
  final int filterType;
  final int filterStatus;

  ChartStats({this.globals, this.filterType, this.filterStatus});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          width: MediaQuery.of(context).size.width * 1.5,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: LineChart(
            chartData(context),
            swapAnimationDuration: const Duration(milliseconds: 250),
          )),
    );
  }

  LineChartData chartData(BuildContext context) {
    return LineChartData(
      lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.redAccent,
            getTooltipItems: (touchedSpots) {
              return touchedSpots
                  .map((e) => LineTooltipItem(
                      NumberUtils.formatNumber(e.y.toInt()),
                      Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.white)))
                  .toList();
            },
          ),
          touchCallback: (LineTouchResponse touchResponse) {},
          handleBuiltInTouches: true,
          fullHeightTouchLine: false),
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        drawHorizontalLine: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            textStyle: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Color(kTextColor), fontSize: 10.0),
            margin: 16,
            interval: ChartUtils.getXaxisInterval(filterType),
            getTitles: (value) {
              return ChartUtils.getXaxisTitles(value, filterType);
            },
            rotateAngle: 45),
        leftTitles: SideTitles(
            showTitles: true,
            margin: 12,
            reservedSize: 30,
            textStyle: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Color(kTextColor), fontSize: 10.0),
            getTitles: (value) {
              return ChartUtils.getYaxisTitles(value, filterStatus);
            }),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(kTextColor),
            width: 1,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: (globals.length).toDouble(),
      maxY: ChartUtils.getMaxYaxis(globals, filterStatus),
      minY: 0,
      lineBarsData: lineBarsData(),
    );
  }

  List<LineChartBarData> lineBarsData() {
    List<FlSpot> confirmedSpots = globals.asMap().entries.map((e) {
      int index = e.key;
      Global global = e.value;
      return FlSpot((index).toDouble(), global.totalConfirmed.toDouble());
    }).toList();

    List<FlSpot> recoveredSpots = globals.asMap().entries.map((e) {
      int index = e.key;
      Global global = e.value;
      return FlSpot((index).toDouble(), global.totalRecovered.toDouble());
    }).toList();

    List<FlSpot> deathSpots = globals.asMap().entries.map((e) {
      int index = e.key;
      Global global = e.value;
      return FlSpot((index).toDouble(), global.totalDeaths.toDouble());
    }).toList();

    final LineChartBarData confirmed = LineChartBarData(
      spots: confirmedSpots,
      isCurved: true,
      colors: [
        const Color(kNewCasesColor),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    final LineChartBarData recovered = LineChartBarData(
      spots: recoveredSpots,
      isCurved: true,
      colors: [
        const Color(kRecoveredCasesColor),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
    );
    final LineChartBarData death = LineChartBarData(
      spots: deathSpots,
      isCurved: true,
      colors: const [
        Color(kDeathCasesColor),
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );

    if (filterStatus == kTotalConfirmed) {
      return [confirmed];
    } else if (filterStatus == kTotalRecovered) {
      return [recovered];
    }
    return [death];
  }
}
