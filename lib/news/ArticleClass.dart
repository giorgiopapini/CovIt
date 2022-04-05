import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';


class TerritoryNews {

  final String name;
  final List<Article> totalArticles;

  TerritoryNews(
    {
      @required this.name,
      @required this.totalArticles,
    }
  );
}


class Article {

  final String title;
  final String author;
  final String date;
  final String url;
  final String imageUrl;

  Article ( 
    {
      @required this.title,
      @required this.author,
      @required this.date,
      @required this.url,
      @required this.imageUrl,
    }
  );

  static Article fromJson(json) => Article (
    title: json["title"],
    author: json["author"],
    date: json["date"],
    url: json["url"],
    imageUrl: json["image_url"],
  );

}