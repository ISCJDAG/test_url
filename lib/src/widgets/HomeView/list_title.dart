// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_urls/src/models/url_model.dart';

class ListTitleUrl extends StatelessWidget {
  //const ListTitleUrl({Key key}) : super(key: key);
  final UrlModel urlModel;
  const ListTitleUrl({required this.urlModel});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: const Icon(Icons.public),
          title: Text(urlModel.originalurl),
        ),
      ),
    );
  }
}
