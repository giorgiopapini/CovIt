import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/analitics/FirstAnaliticsPage.dart';

import 'ChartCommon.dart';

class PointsChart extends StatefulWidget {
  final int cardPadding;
  final int lastDayData;
  final int variation;
  final List<FlSpot> spots;
  final List days;
  final double height;
  final double width;
  final String title;
  final color;
  bool visible;

  PointsChart({
    @required this.cardPadding,
    @required this.lastDayData,
    @required this.variation,
    @required this.spots,
    @required this.days,
    @required this.title,
    @required this.visible,
    this.height = 300,
    this.width,
    this.color = const_blue,
  });

  @override
  _PointsChartState createState() => _PointsChartState();
}

class _PointsChartState extends State<PointsChart> {
  List yValues = [];
  ChartData data = ChartData();

  @override
  void initState() {
    widget.spots.forEach((element) {
      this.yValues.add(element.y.toInt());
    });
    data.setChartData(yValues);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double top = (15 * widget.cardPadding) / 200;
    double right = (32 * widget.cardPadding) / 200;
    return Visibility(
      visible: widget.visible,
      child: Container(
        height: widget.height,
        width: widget.width,
        child: Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.only(top: top, right: right),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 0, 20),
                    child: ChartTitle(
                      title: widget.title,
                      lastDayData: widget.lastDayData,
                      variation: widget.variation,
                    )),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      maxY: data.yMax.toDouble(),
                      minY: data.yMin.toDouble(),
                      titlesData: getTitleData(widget.days, this.data),
                      lineBarsData: [
                        LineChartBarData(
                          colors: [widget.color[400], widget.color],
                          spots: widget.spots,
                          isCurved: true,
                          barWidth: 3,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 3.75,
                                color: const_white,
                                strokeColor: widget.color,
                                strokeWidth: 2.5,
                              );
                            },
                          ),
                          isStrokeCapRound: true,
                        ),
                      ],
                      gridData: getGrid(data.unit),
                      borderData: const_border,
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          tooltipBgColor: Colors.white.withOpacity(0.85),
                          tooltipRoundedRadius: 16,
                        ),
                        touchCallback: (touchResponse) {},
                        handleBuiltInTouches: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
