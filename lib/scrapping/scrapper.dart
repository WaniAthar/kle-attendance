import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Scrapper {
  String? _dd, _mm, _yyyy, _username;
  String url = 'http://student.kletech.ac.in/code/index.php';
  Scrapper() {
    getSharedPrefData();
    _signin();
    _extract();
  }
  void getSharedPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _dd = pref.getString('dd');
    _mm = pref.getString('mm');
    _yyyy = pref.getString('yyyy');
    _username = pref.getString('usn');
    print('$_username\n$_yyyy-$_mm-$_dd');
  }

  Future<void> _signin() async {
    var response = await http
        .get(Uri.parse('https://student.kletech.ac.in/code/index.php'));
    // print(response.statusCode);
  }

  Future<void> _extract() async {}
}
