import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/common/ChartCommon.dart';
import 'package:flutter_application_1/common/ChartLegend.dart';

class RoundChart extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final List<ChartLegend> legends;
  final int lastDayData;
  final double percent;
  bool visible;

  RoundChart({
    @required this.title,
    @required this.height,
    @required this.lastDayData,
    @required this.percent,
    @required this.visible,
    this.legends,
    this.width,
  });

  @override
  _RoundChartState createState() => _RoundChartState();
}

class _RoundChartState extends State<RoundChart> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: AspectRatio(
        aspectRatio: 1.20,
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
                    padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: ChartTitle(
                      title: widget.title,
                      lastDayData: widget.lastDayData,
                      inverted: true,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: (MediaQuery.of(context).size.width * 28) /
                                const_width), //28
                        Expanded(
                          child: PieChart(
                            PieChartData(
                              sections: chartSections(widget.percent,
                                  MediaQuery.of(context).size.width),
                              sectionsSpace: 0,
                              centerSpaceRadius: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.legends == null
                                  ? [Container()]
                                  : buildLegends(widget.legends),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<PieChartSectionData> chartSections(double data, double physicalWidth) {
  return List.generate(2, (i) {
    final fontSize = (physicalWidth * const_fontSize) / const_width;
    final radius = (physicalWidth * const_radius) / const_width;

    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const_blue,
          value: data,
          title: '${(data).toStringAsFixed(1)}%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const_white),
        );
      case 1:
        return PieChartSectionData(
          color: const_red,
          value: (100 - data),
          title: '${(100 - data).toStringAsFixed(1)}%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const_white),
        );
      default:
        throw 'Oh no';
    }
  });
}
