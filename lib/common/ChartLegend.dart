import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';

class ChartLegend extends StatefulWidget {

  final String explanation;
  final Color color;

  ChartLegend(
    {
      @required this.explanation,
      @required this.color,
    }
  );

  @override
  _ChartLegendState createState() => _ChartLegendState();
}

class _ChartLegendState extends State<ChartLegend> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(22.5, 4, 0, 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: widget.color,
            ),
          ),
          Text(" "),
          Text(widget.explanation),
        ],
      ),
    );
  }
}