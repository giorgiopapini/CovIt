import "package:flutter/material.dart";
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/SplashScreen.dart';
import "package:introduction_screen/introduction_screen.dart";

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  Color _color = const_blue;

  void setColor(int index) {
    setState(() {
      switch (index) {
        case 0:
          this._color = const_blue;
          break;
        case 1:
          this._color = const_yellow;
          break;
        case 2:
          this._color = const_green;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Una app... 20 regioni",
              body:
                  "Controlla l'andamento della pandemia in tutte le regioni attraverso una sola app",
              image: getImage('assets/icone_benvenuto/covid_data_image.png'),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: "Dati autorevoli",
              body:
                  "I dati mostrati nell'app provengono direttamente dai canali ufficiali gestiti dal Ministero della Salute italiano",
              image:
                  getImage('assets/icone_benvenuto/covid_lockdown_image.png'),
              decoration: getPageDecoration(context),
            ),
            PageViewModel(
              title: "Proteggiti!",
              body:
                  "Ricordati delle precauzioni, proteggi te stesso e chi ti circonda",
              image:
                  getImage('assets/icone_benvenuto/covid_protect_yourself.png'),
              decoration: getPageDecoration(context),
            )
          ],
          done: Text("Ho Capito"),
          onDone: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LogoScreen()));
          },
          showSkipButton: true,
          skip: Text("Salta"),
          next: Icon(Icons.arrow_forward_rounded),
          dotsDecorator: dotsDecoration(this._color),
          onChange: (index) => this.setColor(index),
        ),
      ),
    );
  }
}

DotsDecorator dotsDecoration(Color color) {
  return DotsDecorator(
    activeColor: color,
    activeSize: Size(25, 10),
    activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  );
}

Image getImage(String path) {
  return Image(
    image: AssetImage(path),
  );
}

PageDecoration getPageDecoration(BuildContext context) {
  return PageDecoration(
    pageColor: const_white,
    titleTextStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    titlePadding: EdgeInsets.fromLTRB(0, 50, 0, 30),
    imagePadding: EdgeInsets.fromLTRB(0, 70, 0, 0),
  );
}
