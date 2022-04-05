import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/common/CircularImage.dart';
import 'package:flutter_application_1/common/ScreenHeader.dart';
import 'package:flutter_application_1/common/SearchWidget.dart';
import 'package:flutter_application_1/news/ArticleClass.dart';
import 'package:flutter_application_1/news/CardRegione.dart';
import 'package:flutter_application_1/news/NewsCard.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
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
            title: "Notizie",
            description: "Visualizza le notizie riguardanti la pandemia",
          ),
          Consumer<List<TerritoryNews>>(
            builder: (context, List<TerritoryNews> regioni, index) {
              if (regioni == null) {
                return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(const_blue));
              } else {
                return Column(
                  children: [
                    SearchWidget(
                      oldQuery: this.query,
                      callback: this.callback,
                    ),
                    buildNewsList(regioni.getRange(1, regioni.length).toList(),
                        this.query),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

Widget buildNewsList(List<TerritoryNews> territories, String searchedText) {
  return ListView.builder(
    primary: false,
    shrinkWrap: true,
    itemCount: territories.length,
    itemBuilder: (context, index) {
      final TerritoryNews territory = territories[index];
      final String assetDir =
          'assets/stemmi_regioni/stemma_${territory.name.toLowerCase()}.png';
      return (searchedText == null ||
                  territory.name
                      .toLowerCase()
                      .contains(searchedText.toLowerCase())) &&
              territory.name.toLowerCase() != "italia"
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CardRegione(
                  territory: territory,
                  imageDir: assetDir,
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                ),
                const_divider,
              ],
            )
          : Container();
    },
  );
}
