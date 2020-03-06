import 'package:flutter/material.dart';
import '../funcs/navbar.dart';

class CalendarShiftZA extends StatefulWidget {
  @override
  _CalendarShiftZAState createState() => new _CalendarShiftZAState();
}

class _CalendarShiftZAState extends State<CalendarShiftZA> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Kalender-Schicht-Zeitarbeit'),
        ),
        drawer: NavBar()
    );
  }
}
