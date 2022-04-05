import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/common/CircularImage.dart';
import 'package:flutter_application_1/common/FormAppBar.dart';
import 'package:flutter_application_1/news/ArticleClass.dart';
import 'package:flutter_application_1/news/NewsCard.dart';
import 'package:provider/provider.dart';

class AllNews extends StatefulWidget {

  final String name;
  final List<Article> news;

  AllNews(
    {
      @required this.name,
      @required this.news,
    }
  );

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const_white,
      appBar: formAppBar(context, widget.name),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: buildNewsList(widget.news),
      ),
    );
  }
}

Widget buildNewsList(List<Article> articles) {
  return ListView.builder(
    addAutomaticKeepAlives: true,
    itemCount: articles.length,
    itemBuilder: (context, index) {
      final Article article = articles[index];
      return NewsCard(
        title: article.title,
        author: article.author,
        hoursAgo: article.date,
        url: article.url,
        imageUrl: article.imageUrl,
      );
    }
  );
}