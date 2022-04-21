// ignore_for_file: unnecessary_getters_setters, unnecessary_overrides

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_urls/src/helpers/urls.dart';
import 'package:test_urls/src/models/url_model.dart';
import 'package:test_urls/src/shareprefs.dart';
import 'package:test_urls/src/utils/url_api.dart';
import 'package:test_urls/src/widgets/dialogs/defualt.dart';
import 'package:test_urls/src/widgets/dialogs/waiting.dart';

class UrlController extends GetxController {
  static UrlController get to {
    return Get.find<UrlController>();
  }

  final _urlApi = UrlApi();
  late TextEditingController _inputUrl;
  late bool _emptyInput, _urlIncorrect;
  final AccountPrefs _accountPrefs = AccountPrefs();
  late List<UrlModel> _listModel;

  //Geters
  UrlApi get urlApi => _urlApi;
  TextEditingController get inputUrl => _inputUrl;
  bool get emptyInput => _emptyInput;
  bool get urlIncorrect => _urlIncorrect;
  List<UrlModel> get listModel => _listModel;

  set emptyInput(bool value) => _emptyInput = value;
  set urlIncorrect(bool value) => _urlIncorrect = value;

  @override
  void onInit() {
    _accountPrefs.initPrefs();

    _inputUrl = TextEditingController();
    _emptyInput = false;
    _urlIncorrect = false;
    _inputUrl.text = '';
    _listModel = [];

    super.onInit();
  }

  @override
  void onReady() {
    _loadUrls();
    super.onReady();
  }

  _loadUrls() async {
    try {
      /*_listModel = _accountPrefs.urlList != ""
          ? UrlModel.decode(_accountPrefs.urlList)
          : [];*/
      await _accountPrefs.initPrefs();

      List<UrlModel> urls = _accountPrefs.urlList != ""
          ? UrlModel.decode(_accountPrefs.urlList)
          : [];
      if (urls.isNotEmpty) {
        _listModel = urls;
        update();
      } else {
        _listModel = [];
        update();
      }

      print(_listModel);
    } catch (e) {
      print(e.toString());
    }
  }

  //validate url is not empty or format
  validateUrl(String url) {
    /* /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/ */
    String pattern =
        r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
    RegExp regExp = RegExp(pattern);
    if (url == "") {
      //dialog
      _emptyInput = true;
      update();
      Get.back();
    } else if (!regExp.hasMatch(url)) {
      //dialog
      _urlIncorrect = true;
      update();
      Get.back();
    }
  }

  sendUrltoShort() async {
    try {
      Get.dialog(
          WaitDialog(
            text: 'Proccesing',
            fontsize: 8,
            fontWeight: FontWeight.w600,
          ),
          barrierDismissible: false);
      validateUrl(_inputUrl.text);
      if (_urlIncorrect == false && _emptyInput == false) {
        Map body = {'url': _inputUrl.text};
        //cabezera....
        var headers = {
          'Content-Type': 'application/json',
        };

        final response = await Urls(
          url: _urlApi.urlApi + _urlApi.post,
          header: headers,
          body: json.encode(body),
        ).saveUrlShort();

        Map dataMap = json.decode(response.body);
        //print(dataMap);
        if (response.statusCode == 200) {
          //save the register in the shareprefs

          _saveDateRetrived(dataMap);
        } else {
          //dialog. error
          Get.back();
          Get.dialog(
            DefaultMessage(
              titulo: 'Error',
              mensaje:
                  'Something was wrong, we can find it that patition. To the server.',
              popped: false,
              onPopped: () {
                //update list and
                Get.back();
              },
            ),
            barrierDismissible: false,
            transitionDuration: const Duration(milliseconds: 200),
          ).then((value) {});
        }
      }
    } catch (e) {
      String error = "We can not connect with the server, please try it later.";
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      Get.dialog(
        DefaultMessage(
          titulo: 'Error',
          mensaje: error,
          onPopped: () {},
        ),
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 200),
      );
    }
  }

  _saveDateRetrived(Map dataMap) {
    List<UrlModel> currentData = _accountPrefs.urlList != ""
        ? UrlModel.decode(_accountPrefs.urlList)
        : [];

    if (_accountPrefs.urlList != "") {
      currentData.add(UrlModel(
        alias: dataMap['alias'],
        originalurl: dataMap['_links']['self'],
        shortUrl: dataMap['_links']['short'],
      ));
      final String encodeAddData = UrlModel.encode(currentData);
      _accountPrefs.urlList = encodeAddData;
    } else {
      final String encodeNewData = UrlModel.encode([
        UrlModel(
          alias: dataMap['alias'],
          originalurl: dataMap['_links']['self'],
          shortUrl: dataMap['_links']['short'],
        )
      ]);
      _accountPrefs.urlList = encodeNewData;
    }

    Get.back();
    Get.dialog(
      DefaultMessage(
        titulo: 'God Job!',
        mensaje: 'Url saved succes.',
        popped: false,
        onPopped: () {
          //update list and
          Get.back();
          _inputUrl.text = '';
          _loadUrls();
        },
      ),
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 200),
    ).then((value) {});

    //print(_accountPrefs.urlList);
    //show dialgo saved
  }
}
