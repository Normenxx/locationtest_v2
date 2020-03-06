import "package:flutter/material.dart";
import 'package:locationtest_v2/pages/homepage.dart';
import 'package:intl/date_symbol_data_local.dart';

void main(){
  initializeDateFormatting().then((_) => runApp(new MaterialApp(
    title: 'Flutter',
    home: new HomePage(),
  )));
}