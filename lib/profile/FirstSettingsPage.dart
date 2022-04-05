import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/ScreenHeader.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ScreenHeader(
            title: "Impostazioni",
            description: "Personalizza la tua esperienza con CovIt",
          ),
        ],
      ),
    );
  }
}