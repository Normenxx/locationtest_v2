import 'package:flutter/material.dart';
import '../funcs/navbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Startseite'),
        ),
        drawer: NavBar()
    );
  }
}
