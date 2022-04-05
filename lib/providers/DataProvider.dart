import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/news/ArticleClass.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object
import 'package:html/dom.dart';

class RegioniAll {
  List<Territory> territories = [];
  List<TerritoryNews> news = [];
  List<TerritoryVaccine> vaccineData = [];

  Map dividedData = new Map<String, List>();

  void updateRegioniData(List<DailyTerritory> original) async {
    original.forEach((element) {
      if (this.dividedData.containsKey(element.name) == false) {
        this.dividedData[element.name] = [];
      }
      this.dividedData[element.name].add(element);
    });
  }

  void createList() async {
    this.dividedData.forEach((key, value) {
      this.territories.add(new Territory(
            name: key.toString(),
            totalData: value,
          ));
    });
  }

  dynamic loadFromURL(var response, var file, String url) async {
    response = await http.get(Uri.parse(url));
    file.writeAsString(response.body);
    return response;
  }

  dynamic justUploaded(File file, DateTime date) async {
    List strings;
    if (file.existsSync() == false) {
      await file.writeAsString("0/${date.day}");
      return true;
    } else {
      strings = file.readAsStringSync().split("/");
      if (int.parse(strings[0]) < 1) {
        return true;
      } else {
        return false;
      }
    }
  }

  void update(File uptimes, bool reset) async {
    int unit = 0;
    if (reset == false) {
      unit = int.parse(uptimes.readAsStringSync().split("/")[0]) + 1;
    }
    await uptimes
        .writeAsString("${unit.toString()}/${DateTime.now().day.toString()}");
  }

  Future<List<Territory>> fetchDataRegioniAll() async {
    // regioni-latest --> https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni-latest.json
    // regioni-all --> https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni.json
    // province --> https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-province.json
    // dati nazionali (Italia) all --> https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json
    // nations-all --> https://pkgstore.datahub.io/core/covid-19/countries-aggregated_json/data/bcc5e3f43d8f60e9fa85e7886fe7b487/countries-aggregated_json.json

    final Directory dir = await getApplicationDocumentsDirectory();
    final String filePath = '${dir.path}/dati_json.txt';
    final File file = File(filePath);
    final url =
        "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni.json";

    var response;
    var body;

    if (file.existsSync()) {
      final DateTime lastModifiedDate = await file.lastModified();
      final File uptimes = File("${dir.path}/uptimes.txt");
      if (lastModifiedDate.day != DateTime.now().day) {
        await this.update(uptimes, true);
        response = await this.loadFromURL(response, file, url);
        body = json.decode(response.body);
      } else if (DateTime.now().hour >= 18 &&
          await this.justUploaded(uptimes, DateTime.now())) {
        await this.update(uptimes, false);
        response = await this.loadFromURL(response, file, url);
        body = json.decode(response.body);
      } else {
        response = File('${dir.path}/dati_json.txt').readAsStringSync();
        body = jsonDecode(response);
      }
    } else {
      response = await this.loadFromURL(response, file, url);
      body = json.decode(response.body);
    }

    final List rawTerritories =
        await body.map<DailyTerritory>(DailyTerritory.fromJson).toList();
    rawTerritories.sort((a, b) => a.name.compareTo(b.name));

    updateRegioniData(rawTerritories);
    createList();

    return this.territories;
  }

  void retryRequest(future, delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      future();
    });
  }

  Future<List<TerritoryNews>> fetchNewsAll() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String filePath = '${dir.path}/news_json.txt';
    final File file = File(filePath);
    final url =
        "https://raw.githubusercontent.com/news-dev/news-data/main/news.json";
    var response;
    var body;
    List<TerritoryNews> allNews = [];

    if (file.existsSync()) {
      final DateTime lastModifiedDate = await file.lastModified();
      if ((DateTime.now().minute) - (lastModifiedDate.minute) >= 10) {
        response = await this.loadFromURL(response, file, url);
        body = json.decode(response.body);
      } else {
        response = File('${dir.path}/news_json.txt').readAsStringSync();
        body = jsonDecode(response);
      }
    } else {
      response = await this.loadFromURL(response, file, url);
      body = json.decode(response.body);
    }

    body.forEach((String key, dynamic value) {
      List<Article> articles = [];
      for (var ele in value) {
        articles.add(Article.fromJson(ele));
      }
      allNews.add(TerritoryNews(
        name: key,
        totalArticles: articles,
      ));
    });
    return allNews;
  }

  Future<List<TerritoryVaccine>> fetchVaccineDataRegioni() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String filePath = '${dir.path}/vaccine_json.txt';
    final File file = File(filePath);
    final url =
        "https://raw.githubusercontent.com/italia/covid19-opendata-vaccini/master/dati/vaccini-summary-latest.json";

    var response;
    var body;

    if (file.existsSync()) {
      final DateTime lastModifiedDate = await file.lastModified();
      final File uptimes = File("${dir.path}/uptimes_vaccine.txt");
      if (lastModifiedDate.day != DateTime.now().day) {
        await this.update(uptimes, true);
        response = await http.get(Uri.parse(url));
        file.writeAsString(response.body);
        body = json.decode(response.body)["data"];
      } else if (DateTime.now().hour >= 18 &&
          await this.justUploaded(uptimes, DateTime.now())) {
        await this.update(uptimes, false);
        response = await http.get(Uri.parse(url));
        file.writeAsString(response.body);
        body = json.decode(response.body)["data"];
      } else {
        response = File('${dir.path}/vaccine_json.txt').readAsStringSync();
        body = jsonDecode(response)["data"];
      }
    } else {
      response = await http.get(Uri.parse(url));
      file.writeAsString(response.body);
      body = json.decode(response.body)["data"];
    }

    this.vaccineData =
        await body.map<TerritoryVaccine>(TerritoryVaccine.fromJson).toList();

    return this.vaccineData;
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}
