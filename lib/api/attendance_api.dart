import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class API extends ChangeNotifier {
  String? usn;
  String? yyyy;
  String? mm;
  String? dd;
  String? dob;
  String? url;
  dynamic personalData, attendanceData;
  bool isDataFetched = false;
  // these variables are for the communication of FutureBuilders in multiple screens
  bool fetchErr = false;

  void getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    usn = pref.getString('usn');
    yyyy = pref.getString('yyyy');
    mm = pref.getString('mm');
    dd = pref.getString('dd');
    dob = '$yyyy-$mm-$dd';
  }

//  split the full name into first name and last name
  String fullNameSplit(String name) {
    List<String> nameList = name.split(" ");
    if (nameList.length > 2) {
      return "${nameList.first} ${nameList.last}";
    }
    return name;
  }
//  dummy api function to work on with 
Future<void> getData(){
  personalData = {"name":"John Doe", "usn":"01fe20bbb043"};
  attendanceData =[{"cie_marks":"20/20","course_attendance":"55%","course_code":"20ECSk303","course_name":"Computer Networks-2","course_teacher":"John Doe"},{"cie_marks":"15/15","course_attendance":"93%","course_code":"20ECKC305","course_name":"Distributed & Cloud Computing","course_teacher":"Mark Henry"},{"cie_marks":"0/0","course_attendance":"0%","course_code":"16EHUC301","course_name":"PA & LR","course_teacher":"Albert Einstein"},{"cie_marks":"0/0","course_attendance":"75%","course_code":"20EOSP305","course_name":"Computer Networks Lab","course_teacher":"Newton"},{"cie_marks":"0/0","course_attendance":"0%","course_code":"15EPSW302","course_name":"Minor Project","course_teacher":"Tim Cook"},{"cie_marks":"0/0","course_attendance":"73%","course_code":"20ECSK307","course_name":"Blockchain and Distributed Ledgers","course_teacher":"Shimsuke Nakamura"},{"cie_marks":"20/20","course_attendance":"39%","course_code":"19ELSE303","course_name":"Semantic Web","course_teacher":"Tim Lee"},{"cie_marks":"0/0","course_attendance":"0%","course_code":"17PCSE307","course_name":"Parallel Computing","course_teacher":"Messi"},{"cie_marks":"0/0","course_attendance":"0%","course_code":"22EMSH302","course_name":"Industry Readiness and Leadership Skills","course_teacher":"Kabir singh"}]
  // delay the data fetch by 2 seconds
  Future.delayed(Duration(seconds: 5), () {
    isDataFetched = true;
    notifyListeners();
  });
}
}
