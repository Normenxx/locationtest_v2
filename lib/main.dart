import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locationtest_v2/LocationListPage.dart';
import 'AttendancePage.dart';
import 'LocationMarker.dart';
import 'MapPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Open Google Maps'),
              onPressed: () {// Navigate to second route when tapped.
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Map()));
              },
            ),
            RaisedButton(
              child: Text('Anwesenheitbestätigen'),
              onPressed: () {// Navigate to second route when tapped.
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Attendance()));
              },
            ),
            RaisedButton(
              child: Text('Markerliste'),
              onPressed: () {// Navigate to second route when tapped.
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationListPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}

