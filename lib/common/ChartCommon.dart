import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/common/ChartLegend.dart';

class ChartTitle extends StatefulWidget {
  final String title;
  final int lastDayData;
  final int variation;
  final bool inverted;

  ChartTitle({
    @required this.title,
    @required this.lastDayData,
    this.variation,
    this.inverted = false,
  });

  @override
  _ChartTitleState createState() => _ChartTitleState();
}

class _ChartTitleState extends State<ChartTitle> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: const_black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        text: "${widget.title}: ",
        children: [
          TextSpan(
            text: widget.lastDayData.toString(),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: widget.variation != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "  (${widget.variation >= 0 ? "+" : ""}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: changeColor(widget.inverted, widget.variation),
                        ),
                      ),
                      Text(
                        "${widget.variation})",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: changeColor(widget.inverted, widget.variation),
                        ),
                      ),
                      buildIcon(widget.variation, widget.inverted),
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}

Color changeColor(bool inverted, int variation) {
  if (inverted == false) {
    return variation > 0 ? const_red : const_green;
  } else {
    return variation > 0 ? const_green : const_red;
  }
}

Widget buildIcon(int variation, bool inverted) {
  if (variation > 0) {
    return Icon(Icons.arrow_drop_up_sharp,
        size: 30, color: changeColor(inverted, variation));
  } else {
    return Icon(Icons.arrow_drop_down_sharp,
        size: 30, color: changeColor(inverted, variation));
  }
}

List<ChartLegend> buildLegends(List<ChartLegend> legends) {
  return List.generate(legends.length, (index) {
    return legends[index];
  });
}

class Date {
  double parsedData;
  DateTime realDate;
  String day;
  String month;
  String year;

  void formatDate(String dateString) {
    this.parsedData =
        DateTime.parse(dateString).millisecondsSinceEpoch.toDouble();
    this.realDate =
        DateTime.fromMillisecondsSinceEpoch(this.parsedData.toInt());
    this.year = this.realDate.toIso8601String().split("T")[0].split("-")[0];
    this.month = this.realDate.toIso8601String().split("T")[0].split("-")[1];
    this.day = this.realDate.toIso8601String().split("T")[0].split("-")[2];
  }
}

class ChartData {
  int yMax = 0;
  int yMin = 0;
  double unit = 0;
  List yValuesDisplay = [];

  void setChartData(List yValues) {
    this.yMax = yValues.reduce((curr, next) => curr > next ? curr : next);
    this.yMax += 10 - (this.yMax % 10);
    this.yMin = yValues.reduce((curr, next) => curr < next ? curr : next);
    this.yMin -= (this.yMin % 10);

    this.unit = (this.yMax - this.yMin) / 5;

    double num = this.yMin.toDouble();
    while (num <= (this.yMax + this.unit)) {
      if (num <= 0) {
        this.yValuesDisplay.add(0);
      } else {
        this.yValuesDisplay.add(num);
      }
      num += this.unit;
    }
    this.yMax = this.yValuesDisplay[this.yValuesDisplay.length - 2].toInt();
  }
}

FlTitlesData getTitleData(List days, ChartData data) {
  Date date = Date();
  int variation = days.length ~/ const_x_length;

  return FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      getTitles: (value) {
        String title;
        if ((value.toInt() % variation) == 0) {
          date.formatDate(days[value.toInt()].date);
          title = "${date.day}/${date.month}";
        } else {
          title = "";
        }
        return title;
      },
    ),
    leftTitles: SideTitles(
      showTitles: true,
      getTitles: (value) {
        if (data.yValuesDisplay.contains(value)) {
          return value.toInt().toString();
        }
        return "";
      },
      interval: 1,
      reservedSize: 40,
    ),
  );
}

FlGridData getGrid(double unit) {
  return FlGridData(
    show: true,
    horizontalInterval: unit,
    getDrawingHorizontalLine: (value) {
      return FlLine(
        color: Colors.grey.shade300,
        dashArray: [12, 6],
      );
    },
  );
}
