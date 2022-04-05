import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/analitics/CountryClass.dart';
import 'package:flutter_application_1/common/SlidePageTransition.dart';
import 'package:flutter_application_1/news/AllNews.dart';

class RankingRegioni extends StatefulWidget {
  final List<Territory> sortedRegioni;
  final int length;

  RankingRegioni({
    @required this.sortedRegioni,
    @required this.length,
  });

  @override
  _RankingRegioniState createState() => _RankingRegioniState();
}

class _RankingRegioniState extends State<RankingRegioni> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Regioni con piú infetti: ",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
