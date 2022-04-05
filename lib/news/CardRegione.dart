import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/common/CircularImage.dart';
import 'package:flutter_application_1/common/SlidePageTransition.dart';
import 'package:flutter_application_1/news/AllNews.dart';
import 'ArticleClass.dart';
import 'NewsCard.dart';

class CardRegione extends StatefulWidget {
  final String title;
  final TerritoryNews territory;
  final String imageDir;
  final EdgeInsets padding;

  CardRegione({
    @required this.territory,
    this.title,
    this.imageDir,
    this.padding,
  });

  @override
  _CardRegioneState createState() => _CardRegioneState();
}

class _CardRegioneState extends State<CardRegione> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding == null ? EdgeInsets.zero : widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.imageDir == null
                  ? Container()
                  : CircleImage(size: 14, assetDir: widget.imageDir),
              Expanded(
                child: Text(
                  widget.title != null
                      ? widget.title
                      : "  ${widget.territory.name}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "Mostra tutto",
                    style: TextStyle(
                      color: const_blue,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            SlidePageTransition(
                                page: AllNews(
                                    name: widget.territory.name,
                                    news: widget.territory.totalArticles)));
                      }),
              ),
            ],
          ),
          SizedBox(height: 9),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return NewsCard(
                  title: widget.territory.totalArticles[index].title,
                  author: widget.territory.totalArticles[index].author,
                  hoursAgo: widget.territory.totalArticles[index].date,
                  url: widget.territory.totalArticles[index].url,
                  imageUrl: widget.territory.totalArticles[index].imageUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
