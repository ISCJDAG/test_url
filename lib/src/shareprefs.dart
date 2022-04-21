// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class AccountPrefs {
  static final AccountPrefs _acccountInstancia = AccountPrefs._internal();

  factory AccountPrefs() {
    return _acccountInstancia;
  }

  AccountPrefs._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String get urlList {
    return _prefs?.getString('urlList') ?? '';
  }

  set urlList(String value) {
    _prefs?.setString('urlList', value);
  }
}
