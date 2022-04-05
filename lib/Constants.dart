import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'common/ChartCommon.dart';
import 'common/CircularImage.dart';

const Color const_blue = Colors.blue;
const Color const_white = Colors.white;
const Color const_black = Colors.black;
const Color const_grey = Colors.grey;
const Color const_red = Colors.red;
const Color const_green = Colors.green;
const Color const_yellow = Color.fromARGB(255, 255, 201, 14);
const Color const_orange = Colors.orange;

const String const_name = "Name";
const String const_username = "Username";
const String const_email = "Email";
const String const_password = "Password";
const String const_news_url_base = "https://news.google.com/search?for=covid+";

const int const_x_length = 7;
const int const_fontSize = 16;
const int const_radius = 90;

const double const_width = 392.727272;

const List<String> const_regioni_name = [
  "Abruzzo",
  "Basilicata",
  "Calabria",
  "Campania",
  "Emilia-Romagna",
  "FriuliVeneziaGiulia",
  "Lazio",
  "Liguria",
  "Lombardia",
  "Marche",
  "Molise",
  "Bolzano",
  "Trento",
  "Piemonte",
  "Puglia",
  "Sardegna",
  "Sicilia",
  "Toscana",
  "Umbria",
  "ValledAosta",
  "Veneto",
];

const List<String> const_chart_names = [
  "Positivi",
  "Isolamento domiciliare",
  "Decessi",
  "Ospedalizzati",
  "Vaccini",
];

const EdgeInsets const_padding = EdgeInsets.fromLTRB(20, 5, 20, 35);

FlBorderData get const_border {
  return FlBorderData(
    border: Border(
      bottom: BorderSide(
        color: const_grey,
        width: 2,
      ),
      left: BorderSide(
        color: const_grey,
        width: 2,
      ),
    ),
  );
}

Divider get const_divider {
  return Divider(
    thickness: 1.5,
    indent: 12,
    endIndent: 12,
  );
}

Widget region_title(String territoryName, String imageDir, Date date) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            territoryName,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "Ultimo aggiornamento: ${date.day}/${date.month}/${date.year}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal, 
              color: const_grey,
            )
          ),
        ],
      ),
      Align(
        alignment: Alignment.centerRight,
        child: CircleImage(
          size: 28,
            assetDir: imageDir,
          ),
        ),
      ],
    );
}