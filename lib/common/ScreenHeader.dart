import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/common/CircularImage.dart';

class ScreenHeader extends StatefulWidget {

  final String title;
  final String description;
  final String imageDir;

  ScreenHeader(
    {
      @required this.title,
      @required this.description,
      this.imageDir,
    }
  );

  @override
  _ScreenHeaderState createState() => _ScreenHeaderState();
}

class _ScreenHeaderState extends State<ScreenHeader> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 35),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 25),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.imageDir != null ? CircleImage(size: 16, assetDir: widget.imageDir) : Container(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title, 
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold, 
                      )
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal, 
                        color: const_grey,
                      )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}