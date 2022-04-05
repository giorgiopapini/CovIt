import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';


Widget homePageAppbar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: const_white,
    elevation: 0,
    title: Text("TITLE", style: TextStyle(color: const_black)),
    leading: Icon(Icons.settings, color: const_black),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search_rounded, color: const_black),
        onPressed: () {
          print("PRESSED");
        },
        tooltip: "Search",
      ),
    ],
  );
}