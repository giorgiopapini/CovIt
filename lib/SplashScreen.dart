import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/common/CircularImage.dart';
import 'package:flutter_application_1/homepage/MyHomePage.dart';
import 'package:provider/provider.dart';
import 'analitics/CountryClass.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());
    });
  }

  void changePage(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 400));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const_blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              height: 140,
              width: 190,
              image: AssetImage("assets/immagini_logo/logo_white_large.png"),
            ),
            Consumer<List<Territory>>(
                builder: (context, List<Territory> regioni, index) {
              return Consumer<List<TerritoryVaccine>>(
                builder:
                    (context, List<TerritoryVaccine> regioniVaccine, index) {
                  if (regioni == null || regioniVaccine == null) {
                    return SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(const_white)),
                    );
                  } else {
                    this.changePage(context);
                    return SizedBox(
                        height: 30,
                        child: Text(
                          "",
                          style: TextStyle(color: const_blue),
                        ));
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
