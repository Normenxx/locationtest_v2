import 'package:flutter/material.dart';
import '../funcs/navbar.dart';

class CalendarEvent extends StatefulWidget {
  @override
  _CalendarEventState createState() => new _CalendarEventState();

}

class _CalendarEventState extends State<CalendarEvent> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Kalender-Event'),
        ),
        drawer: NavBar()
    );
  }
}
