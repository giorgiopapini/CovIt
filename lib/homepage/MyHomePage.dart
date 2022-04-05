import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/homepage/HomePageAppBar.dart';
import 'package:flutter_application_1/homepage/HomePageBody.dart';
import 'package:flutter_application_1/analitics/FirstAnaliticsPage.dart';
import 'package:flutter_application_1/news/FirstNewsPage.dart';
import 'package:flutter_application_1/profile/FirstSettingsPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 1;
  final tabs = [
    AnaliticsPage(),
    HomePageBody(),
    NewsPage(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const_white,
        //appBar: homePageAppbar(),
        body: SafeArea(
          child: IndexedStack(
            index: this.index,
            children: this.tabs,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const_white,
          elevation: 0,
          iconSize: 28,
          selectedFontSize: 13,
          showUnselectedLabels: false,
          currentIndex: this.index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.signal_cellular_alt_rounded),
              label: "Dati",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons
                  .library_books_rounded), //bar_chart_rounded, analytics_rounded
              label: "Notizie",
            ),
          ],
          onTap: (tappedIndex) {
            setState(() {
              this.index = tappedIndex;
            });
          },
        ),
      ),
    );
  }
}
