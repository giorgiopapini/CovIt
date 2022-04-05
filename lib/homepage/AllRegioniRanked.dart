import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/analitics/FirstAnaliticsPage.dart';
import 'package:flutter_application_1/common/FormAppBar.dart';
import 'package:flutter_application_1/common/SlidePageTransition.dart';
import 'package:flutter_application_1/news/AllNews.dart';
import 'package:flutter_application_1/news/ArticleClass.dart';

class AllRegioniRanked extends StatefulWidget {
  final List<Territory> sortedRegioni;
  final List<TerritoryNews> sortedNews;
  final List<TerritoryVaccine> sortedVaccine;
  final String pageName;

  AllRegioniRanked({
    @required this.sortedRegioni,
    @required this.sortedNews,
    @required this.sortedVaccine,
    @required this.pageName,
  });

  @override
  _AllRegioniRankedState createState() => _AllRegioniRankedState();
}

class _AllRegioniRankedState extends State<AllRegioniRanked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const_white,
      appBar: formAppBar(context, widget.pageName),
      body: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: buildList(widget.sortedRegioni, widget.sortedNews,
              widget.sortedVaccine, widget.pageName)),
    );
  }
}
