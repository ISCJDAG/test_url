// ignore_for_file: use_key_in_widget_constructors, file_names, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class InputDesingerText extends StatelessWidget {
  //const name({Key key}) : super(key: key);

  // ignore: use_key_in_widget_constructors
  final controller;
  InputDesingerText({this.controller});

  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Container(
      width: w * 0.7,
      height: h * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.url,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          hintText: 'Url',
          border: OutlineInputBorder(),
          labelStyle:
              TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        //controller: ,
      ),
    );
  }
}
