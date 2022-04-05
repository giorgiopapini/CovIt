import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';

class CircleImage extends StatefulWidget {

  final double size;
  final String assetDir;

  CircleImage(
    {
      @required this.size,
      @required this.assetDir,
    }
  );

  @override
  _CircleImageState createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.size,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        child: Image.asset(widget.assetDir),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}