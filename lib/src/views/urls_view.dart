// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_urls/src/controller/url_home_controller.dart';
import 'package:test_urls/src/widgets/HomeView/inputText.dart';
import 'package:test_urls/src/widgets/HomeView/list_title.dart';

class HomeView extends StatelessWidget {
  //const HomeView({Key key}) : super(key: key);
  final UrlController _urlController = UrlController();
  late double w, h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: GetBuilder<UrlController>(
        init: _urlController,
        builder: (_) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InputDesingerText(controller: _.inputUrl),
                      btn_send_url(context, _),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text('Recently shortened URLs',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 4,
                  child: list_of_shortsUrl(_),
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //btn send
  btn_send_url(BuildContext context, UrlController _) {
    return TextButton(
      onPressed: () {
        //code for send the url.

        _.sendUrltoShort();

        if (_.emptyInput == true) {
          _emptyValue_Valid_Dialog(context, _, 'Empty Value',
              'Please provide a value in the input.');
        }
        if (_.urlIncorrect == true) {
          _emptyValue_Valid_Dialog(
              context, _, 'Url Invalid', 'Please provide a correct Url.');
        }
      },
      child: const Icon(
        Icons.send,
        color: Colors.white,
      ),
    );
  }

  //list of shortUrls added
  list_of_shortsUrl(UrlController _) {
    return Container(
      width: w * 0.9,
      child: ListView.builder(
          itemCount: _.listModel.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            print(_.listModel[index]);
            return ListTitleUrl(
              urlModel: _.listModel[index],
            );
          }),
    );
  }

  //Dialog of emptyValue
  Future<void> _emptyValue_Valid_Dialog(
      BuildContext context, UrlController _, String title, String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(msg),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                _.emptyInput = false;
                _.urlIncorrect = false;
                _.update();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
      // );
    );
  }
}
