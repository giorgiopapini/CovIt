import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/news/ArticleClass.dart';
import 'package:html/parser.dart';

class Territory {
  final String name;
  final List totalData;
  List lastWeek = [];
  List<Article> news = [];

  DailyTerritory getLastDay() {
    return this.totalData[this.totalData.length - 1];
  }

  void orderingData() {
    this.totalData.sort((a, b) {
      return a.date.compareTo(b.date);
    });
  }

  Territory({
    @required this.name,
    @required this.totalData,
  }) {
    this.orderingData();
    this.lastWeek = this
        .totalData
        .sublist(this.totalData.length - 7, this.totalData.length);
  }
}

class DailyTerritory {
  String name;
  String date;
  int code;

  int totalCases;
  int totalInfected;
  int totalInfectedVariation;
  int totalRecoveryRoom;
  int totalHospitalized;
  int totalHealed;
  int newInfected;
  int deaths;

  DailyTerritory({
    @required this.name,
    @required this.code,
    @required this.date,
    @required this.newInfected,
    @required this.deaths,
    @required this.totalHealed,
    @required this.totalHospitalized,
    @required this.totalRecoveryRoom,
    @required this.totalInfectedVariation,
    @required this.totalInfected,
    @required this.totalCases,
  });

  static DailyTerritory fromJson(json) => DailyTerritory(
        name: json["denominazione_regione"],
        code: json["codice_regione"],
        date: json["data"],
        newInfected: json["nuovi_positivi"],
        deaths: json["deceduti"],
        totalHealed: json["dimessi_guariti"],
        totalHospitalized: json["totale_ospedalizzati"],
        totalRecoveryRoom: json["terapia_intensiva"],
        totalInfectedVariation: json["variazione_totale_positivi"],
        totalInfected: json["totale_positivi"],
        totalCases: json["totale_casi"],
      );
}

class TerritoryVaccine {
  final String name;
  final double percentDosesDone;
  final int deliveredDoses;
  final int doneDoses;
  int variation;

  TerritoryVaccine({
    @required this.name,
    @required this.percentDosesDone,
    @required this.deliveredDoses,
    @required this.doneDoses,
  });

  static TerritoryVaccine fromJson(json) => TerritoryVaccine(
        name: json["nome_area"],
        percentDosesDone: json["percentuale_somministrazione"],
        deliveredDoses: json["dosi_consegnate"],
        doneDoses: json["dosi_somministrate"],
      );
}
