import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/common/ChartCommon.dart';
import 'package:flutter_application_1/common/ChartLegend.dart';

class ColChart extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final List<BarChartGroupData> rows;
  final List days;
  final List<ChartLegend> legends;
  final int lastDayData;
  final int variation;
  bool visible;

  ColChart({
    @required this.title,
    @required this.height,
    @required this.lastDayData,
    @required this.variation,
    @required this.rows,
    @required this.days,
    @required this.visible,
    this.legends,
    this.width,
  });

  @override
  _ColChartState createState() => _ColChartState();
}

class _ColChartState extends State<ColChart> {
  List yValues = [];
  ChartData data = ChartData();

  @override
  void initState() {
    widget.rows.forEach((element) {
      element.barRods.forEach((element) {
        this.yValues.add(element.y.toInt());
      });
    });
    this.data.setChartData(yValues);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Container(
        height: widget.height,
        width: widget.width,
        child: Card(
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.only(top: 25, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 20),
                  child: ChartTitle(
                    title: widget.title,
                    lastDayData: widget.lastDayData,
                    variation: widget.variation,
                  ),
                ),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      maxY: data.yMax.toDouble() + 0.1,
                      minY: data.yMin.toDouble(),
                      alignment: BarChartAlignment.spaceAround,
                      barGroups: widget.rows,
                      titlesData: getTitleData(widget.days, this.data),
                      gridData: getGrid(data.unit),
                      borderData: const_border,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.legends == null
                      ? [Container()]
                      : buildLegends(widget.legends),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
