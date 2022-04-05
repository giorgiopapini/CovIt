import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/common/ChartCommon.dart';
import 'package:flutter_application_1/common/ChartLegend.dart';
import 'package:flutter_application_1/common/CircularImage.dart';
import 'package:flutter_application_1/common/FormAppBar.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/common/FormBody.dart';
import 'package:flutter_application_1/common/BarChart.dart';
import 'package:flutter_application_1/common/LineChart.dart';
import 'package:flutter_application_1/common/PieChart.dart';
import 'package:flutter_application_1/common/ScreenHeader.dart';
import 'package:flutter_application_1/news/ArticleClass.dart';
import 'package:flutter_application_1/news/CardRegione.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatefulWidget {
  final Territory territory;
  final TerritoryNews territoryNews;
  final TerritoryVaccine territoryVaccine;
  final String assetDir;

  DetailsPage({
    @required this.territory,
    @required this.territoryNews,
    @required this.territoryVaccine,
    @required this.assetDir,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int value = 0;

  @override
  void initState() {
    widget.territory.orderingData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List lastWeek = widget.territory.totalData.sublist(
        widget.territory.totalData.length - 7,
        widget.territory.totalData.length);
    final DailyTerritory lastDay = widget.territory.getLastDay();
    final int newDeaths = lastDay.deaths -
        widget
            .territory.totalData[widget.territory.totalData.length - 2].deaths;
    final int newQuarantined =
        lastDay.totalInfected - lastDay.totalHospitalized;

    final List charts = [
      PointsChart(
        visible: true,
        title: "Positivi",
        height: 250,
        cardPadding: 200,
        days: lastWeek,
        lastDayData: lastDay.totalInfected,
        variation: lastDay.totalInfectedVariation,
        spots: getSpotsInfected(lastWeek),
        color: const_blue,
      ),
      ColChart(
        title: "Isolamento domiciliare",
        visible: true,
        height: 308,
        days: lastWeek,
        lastDayData: newQuarantined,
        variation: newQuarantined -
            (lastWeek[lastWeek.length - 2].totalInfected -
                lastWeek[lastWeek.length - 2].totalHospitalized),
        rows: getQuarantineRowData(lastWeek, const_blue),
      ),
      PointsChart(
        visible: true,
        title: "Decessi",
        height: 250,
        cardPadding: 200,
        lastDayData: lastDay.deaths,
        variation: newDeaths,
        days: lastWeek,
        spots: getSpotsDeaths(lastWeek),
        color: const_red,
      ),
      ColChart(
        title: "Ospedalizzati",
        visible: true,
        height: 308,
        days: lastWeek,
        lastDayData: lastDay.totalHospitalized,
        variation: lastDay.totalHospitalized -
            lastWeek[lastWeek.length - 2].totalHospitalized,
        rows: getHospitalRowData(lastWeek),
        legends: [
          ChartLegend(
            explanation: "Ricoverati con sintomi",
            color: const_green,
          ),
          ChartLegend(
            explanation: "Ricoverati in terapia intensiva",
            color: const_red,
          ),
        ],
      ),
      RoundChart(
        title: "Vaccini somministrati",
        visible: true,
        height: 250,
        lastDayData: widget.territoryVaccine.doneDoses,
        percent: widget.territoryVaccine.percentDosesDone,
        legends: [
          ChartLegend(
            explanation: "Effettuati",
            color: const_blue,
          ),
          ChartLegend(
            explanation: "Non eff.",
            color: const_red,
          ),
        ],
      ),
    ];

    Date date = Date();
    date.formatDate(lastDay.date);

    return Scaffold(
      appBar: formAppBar(context, ""),
      backgroundColor: const_white,
      body: SingleChildScrollView(
        padding: const_padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            region_title(widget.territory.name, widget.assetDir, date),
            SizedBox(
              height: 30,
            ),
            Wrap(
              spacing: 7,
              children: List<Widget>.generate(
                const_chart_names.length,
                (index) {
                  return ChoiceChip(
                    label: Text(const_chart_names[index],
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    selected: this.value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        this.value = index;
                      });
                    },
                  );
                },
              ).toList(),
            ),
            SizedBox(
              height: 20,
            ),
            buildChart(charts, this.value),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 45,
              thickness: 1.5,
              indent: 12,
              endIndent: 12,
            ),
            CardRegione(
                territory: widget.territoryNews, title: "Notizie correlate")
          ],
        ),
      ),
    );
  }
}

Widget buildChart(List chips, int index) {
  return ListView.builder(
    primary: false,
    shrinkWrap: true,
    itemCount: chips.length,
    itemBuilder: (context, i) {
      if (i == index) {
        return chips[i];
      }
      return Container();
    },
  );
}

List<FlSpot> getSpotsInfected(List lastWeek) {
  List<FlSpot> spots = [];

  int variation = lastWeek.length ~/ const_x_length;
  List result = [];
  if (lastWeek[0].runtimeType == DailyTerritory) {
    lastWeek.forEach((element) {
      result.add(element.totalInfected);
    });
  } else {
    result = lastWeek;
  }

  for (int i = 0; i < result.length; i++) {
    if ((i % variation) == 0) {
      spots.add(FlSpot(i.toDouble(), result[i].toDouble()));
    }
  }
  spots.removeAt(spots.length - 1);
  spots.add(FlSpot(
      result.length - 1.toDouble(), result[result.length - 1].toDouble()));
  return spots;
}

List<FlSpot> getSpotsDeaths(List lastWeek) {
  List<FlSpot> spots = [];
  int variation = lastWeek.length ~/ const_x_length;
  for (int i = 0; i < lastWeek.length; i++) {
    if ((i % variation) == 0) {
      spots.add(FlSpot(i.toDouble(), lastWeek[i].deaths.toDouble()));
    }
  }

  return spots;
}

List<BarChartGroupData> getHospitalRowData(List lastWeek) {
  List<BarChartGroupData> rows = [];
  for (int i = 0; i < lastWeek.length; i++) {
    rows.add(BarChartGroupData(barsSpace: 4, x: i, barRods: [
      BarChartRodData(
        y: (lastWeek[i].totalHospitalized - lastWeek[i].totalRecoveryRoom)
            .toDouble(),
        colors: [const_green],
        width: 7,
      ),
      BarChartRodData(
        y: lastWeek[i].totalRecoveryRoom.toDouble(),
        colors: [const_red],
        width: 7,
      ),
    ]));
  }

  return rows;
}

List<BarChartGroupData> getQuarantineRowData(List lastWeek, Color color) {
  List<BarChartGroupData> rows = [];
  for (int i = 0; i < lastWeek.length; i++) {
    rows.add(BarChartGroupData(barsSpace: 4, x: i, barRods: [
      BarChartRodData(
        y: (lastWeek[i].totalInfected - lastWeek[i].totalHospitalized)
            .toDouble(),
        colors: [color],
        width: 7,
      ),
    ]));
  }

  return rows;
}
