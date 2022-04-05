import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/homepage/MyHomePage.dart';

void formatData(Map data) {
  // formatting name data
  String firstLetter = data[const_name][0].toString().toLowerCase();
  data[const_name] = data[const_name].toString().toLowerCase();
  data[const_name] = data[const_name]
      .toString()
      .replaceFirst(firstLetter, firstLetter.toUpperCase());

  // formatting email data
  data[const_email] = data[const_email].toString().toLowerCase();
}

void register(Map data, context) {
  formatData(data);
  print("name: " +
      data[const_name] +
      " ---- username: " +
      data[const_username] +
      " ------ email: " +
      data[const_email]);
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyHomePage()));
}

void login(Map data, context) {
  print("LOOGIN");
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MyHomePage()));
}
