// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaitDialog extends StatelessWidget {
  //const name({Key key}) : super(key: key);
  late double h;
  late double w;
  late final String text;
  final double fontsize;
  final FontWeight fontWeight;
  WaitDialog(
      {required this.text, required this.fontsize, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    text;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
      content: FractionallySizedBox(
        heightFactor: 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FittedBox(
                child: Text(
                  text,
                  style: TextStyle(fontSize: fontsize, fontWeight: fontWeight),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Image.asset('assets/img/Spinner-3.gif',
                  fit: BoxFit.contain, width: w * 0.3, height: h * 0.6),
            ),
          ],
        ),
      ),
    );
  }
}
