import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/analitics/details/DetailsPage.dart';
import 'package:flutter_application_1/common/ChartCommon.dart';
import 'package:flutter_application_1/common/CircularImage.dart';
import 'package:flutter_application_1/common/ScreenHeader.dart';
import 'package:flutter_application_1/common/SearchWidget.dart';
import 'package:flutter_application_1/news/ArticleClass.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/common/SlidePageTransition.dart';

class AnaliticsPage extends StatefulWidget {
  @override
  _AnaliticsPageState createState() => _AnaliticsPageState();
}

class _AnaliticsPageState extends State<AnaliticsPage> {
  final controller = TextEditingController();
  String query;

  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  callback(String newQuery) {
    setState(() {
      this.query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: "Dati Regionali",
            description: "Visualizza la situazione covid regione per regione",
          ),
          Consumer<List<Territory>>(
              builder: (context, List<Territory> regioni, index) {
            return Consumer<List<TerritoryNews>>(
              builder: (context, List<TerritoryNews> regioniNews, index) {
                return Consumer<List<TerritoryVaccine>>(
                  builder:
                      (context, List<TerritoryVaccine> regioniVaccine, index) {
                    if (regioni == null ||
                        regioniNews == null ||
                        regioniVaccine == null) {
                      return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(const_blue));
                    } else {
                      return Column(
                        children: [
                          SearchWidget(
                            oldQuery: this.query,
                            callback: this.callback,
                          ),
                          buildList(
                              regioni,
                              regioniNews
                                  .getRange(1, regioniNews.length)
                                  .toList(),
                              regioniVaccine,
                              this.query),
                        ],
                      );
                    }
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

Widget buildList(
    List<Territory> territories,
    List<TerritoryNews> territoriesNews,
    List<TerritoryVaccine> territoriesVaccine,
    String searchedText) {
  return ListView.builder(
    primary: false,
    shrinkWrap: true,
    itemCount: territories.length,
    itemBuilder: (context, index) {
      final Territory territory = territories[index];
      final TerritoryNews territoryNews = territoriesNews[index];
      final TerritoryVaccine territoryVaccine = territoriesVaccine[index];
      final DailyTerritory lastDay = territory.getLastDay();
      final String assetDir =
          'assets/stemmi_regioni/stemma_${territory.name.toLowerCase()}.png';
      return searchedText == null ||
              territory.name.toLowerCase().contains(searchedText.toLowerCase())
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 55,
                  child: Padding(
                    padding:
                        EdgeInsets.all(0), //EdgeInsets.fromLTRB(1, 1, 1, 1.5),
                    child: Card(
                      elevation: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              SlidePageTransition(
                                  page: DetailsPage(
                                      territory: territory,
                                      territoryNews: territoryNews,
                                      territoryVaccine: territoryVaccine,
                                      assetDir: assetDir)));
                        },
                        child: Tooltip(
                          message: "Variazione attualmente positivi",
                          decoration: BoxDecoration(
                            color: const_blue.withOpacity(0.7),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          child: ListTile(
                            title: Text(territory.name,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: const_black)),
                            leading: CircleImage(
                              size: 16,
                              assetDir: assetDir,
                            ),
                            trailing: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Var. positivi:",
                                        style: TextStyle(
                                            fontSize: 13, color: const_grey)),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            lastDay.totalInfectedVariation > 0
                                                ? "+${lastDay.totalInfectedVariation}"
                                                : lastDay.totalInfectedVariation
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  lastDay.totalInfectedVariation >
                                                          0
                                                      ? const_red
                                                      : const_green,
                                            )),
                                        buildIcon(
                                            lastDay.totalInfectedVariation,
                                            false),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 1.5,
                  indent: 12,
                  endIndent: 12,
                ),
              ],
            )
          : Container();
    },
  );
}
