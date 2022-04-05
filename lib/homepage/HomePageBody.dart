import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/analitics/FirstAnaliticsPage.dart';
import 'package:flutter_application_1/analitics/details/DetailsPage.dart';
import 'package:flutter_application_1/common/ChartCommon.dart';
import 'package:flutter_application_1/common/ChartCommon.dart';
import 'package:flutter_application_1/common/ChartLegend.dart';
import 'package:flutter_application_1/common/LineChart.dart';
import 'package:flutter_application_1/common/BarChart.dart';
import 'package:flutter_application_1/common/PieChart.dart';
import 'package:flutter_application_1/common/ScreenHeader.dart';
import 'package:flutter_application_1/homepage/RankingRegioni.dart';
import 'package:flutter_application_1/news/ArticleClass.dart';
import 'package:flutter_application_1/news/CardRegione.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<List<Territory>>(
          builder: (context, List<Territory> regioni, index) {
        return Consumer<List<TerritoryNews>>(
          builder: (context, List<TerritoryNews> regioniNews, index) {
            return Consumer<List<TerritoryVaccine>>(
              builder: (context, List<TerritoryVaccine> regioniVaccine, index) {
                if (regioni == null ||
                    regioniNews == null ||
                    regioniVaccine == null) {
                  return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(const_blue));
                } else {
                  DailyTerritory lastDay = regioni[0].getLastDay();
                  List lastWeek = weekInfected(regioni);
                  int total = totalVaccinated(regioniVaccine);
                  Date date = Date();
                  date.formatDate(lastDay.date);
                  List sortedRegioni = mostInfectedRegioni(regioni, 3);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const_padding,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 32),
                              child: region_title(
                                  "Italia",
                                  "assets/stemmi_regioni/stemma_italia.png",
                                  date),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RankingRegioni(
                                sortedRegioni: sortedRegioni, length: 3),
                            SizedBox(
                              height: 3,
                            ),
                            buildList(
                                sortedRegioni,
                                getSortedNews(sortedRegioni, regioniNews),
                                getSortedVaccine(sortedRegioni, regioniVaccine),
                                null),
                            SizedBox(
                              height: 20,
                            ),
                            CardRegione(
                                territory: regioniNews[0],
                                title: "Notizie correlate"),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          },
        );
      }),
    );
  }
}

List mostInfectedRegioni(List<Territory> regioni, int length) {
  List<Territory> scrapedList = [...regioni];
  scrapedList.removeAt(0);
  scrapedList.sort((Territory first, Territory second) => second
      .getLastDay()
      .totalInfected
      .compareTo(first.getLastDay().totalInfected));
  return scrapedList.getRange(0, length).toList();
}

List getSortedNews(List<Territory> sorted, List<TerritoryNews> news) {
  List<TerritoryNews> fin = [];
  sorted.forEach((ter) {
    news.forEach((sNews) {
      if (ter.name == sNews.name) {
        fin.add(sNews);
      }
    });
  });
  return fin;
}

List getSortedVaccine(List<Territory> sorted, List<TerritoryVaccine> vaccine) {
  List<TerritoryVaccine> fin = [];
  sorted.forEach((ter) {
    vaccine.forEach((vac) {
      if (ter.name == vac.name) {
        fin.add(vac);
      }
    });
  });
  return fin;
}

List weekInfected(List<Territory> regioni) {
  List weekData = [];
  for (int i = 0; i < 7; i++) {
    int allInfected = 0;
    for (int j = 0; j < regioni.length; j++) {
      allInfected += regioni[j].lastWeek[i].totalInfected;
    }
    weekData.add(allInfected);
  }
  return weekData;
}

int totalVaccinated(List<TerritoryVaccine> territories) {
  int total = 0;
  for (int i = 0; i < territories.length; i++) {
    total += territories[i].doneDoses.toInt();
  }
  return total;
}
