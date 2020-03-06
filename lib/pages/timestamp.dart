import 'package:flutter/material.dart';
import '../funcs/navbar.dart';

class Timestamp extends StatefulWidget {
  @override
  _TimestampState createState() => new _TimestampState();
}

class _TimestampState extends State<Timestamp> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Zeitstempeln'),
        ),
        drawer: NavBar()
    );
  }
}
