import 'package:flutter/material.dart';
import '../funcs/navbar.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => new _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Einstellungen'),
        ),
        drawer: NavBar()
    );
  }
}
