import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/SplashScreen.dart';
import 'package:flutter_application_1/news/ArticleClass.dart';
import 'package:flutter_application_1/providers/DataProvider.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/OnboardingPage.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: const_black,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget renderedPage;

  // /data/user/0/com.example.flutter_application_1/app_flutter/firsttime.txt

  Future<Widget> getFirstPage() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String filePath = '${dir.path}/firsttime.txt';
    File file = File(filePath);

    if (file.existsSync()) {
      return LogoScreen();
    } else {
      final DateTime now = DateTime.now();
      final DateTime date = DateTime(now.year, now.month, now.day);
      file.writeAsString(
          "CovIt é stata avviata per la prima volta in data --> $date");
      return OnBoardingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder(
        future: this.getFirstPage(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container();
            default:
              if (snapshot.hasError) {
                return Container();
              } else {
                return MultiProvider(
                    providers: [
                      FutureProvider<List<Territory>>(
                        initialData: null,
                        create: (_) async => RegioniAll().fetchDataRegioniAll(),
                      ),
                      FutureProvider<List<TerritoryNews>>(
                        initialData: null,
                        create: (_) async => RegioniAll().fetchNewsAll(),
                      ),
                      FutureProvider<List<TerritoryVaccine>>(
                        initialData: null,
                        create: (_) async =>
                            RegioniAll().fetchVaccineDataRegioni(),
                      ),
                    ],
                    child: MaterialApp(
                      title: "CovIt",
                      theme: ThemeData(
                        textTheme: TextTheme(
                            subtitle1: TextStyle(color: Colors.white)),
                        primaryColor: const_blue,
                        primarySwatch: const_blue,
                        accentColor: const_white,
                      ),
                      home: snapshot.data,
                    ));
              }
          }
        },
      ),
    );
  }
}
