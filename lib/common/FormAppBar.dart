import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';

void returnToBootPage(BuildContext context) {
  Navigator.pop(context);
}

Widget formAppBar(BuildContext context, String text) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back_rounded),
      color: const_black,
      onPressed: () => returnToBootPage(context),
    ),
    titleSpacing: 0,
    title: Text(text, style: TextStyle(color: const_black)),
    backgroundColor: const_white,
    elevation: 0,
  );
}
