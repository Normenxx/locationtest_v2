import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Attendance.dart';
import 'LocationMarker.dart';
import 'Map.dart';

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
  Set<Marker> markers = {};
  Set<Circle> circles = {};

  void dataVonMarker(){
    for(LocationMarker m in markers){
      print("ID: " + m.markerId.toString() + " LatLng: " + m.position.toString() + "kreis:" + m.circle.circleId.toString());
      if(m is LocationMarker)
        print("Ist ein LocationMarker");

      if(m is Marker)
        print("Ist ein Marker");

      if(m.onDragEnd == null){
        print("Function ist null");
      }
    }
  }

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
                    MaterialPageRoute(builder: (context) => Map(markers: markers,circles: circles,)));
              },
            ),
            RaisedButton(
              child: Text('Anwesenheitbestätigen'),
              onPressed: () {// Navigate to second route when tapped.
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Attendance(markers: markers,)));
              },
            ),
            RaisedButton(
              child: Text('Test'),
              onPressed: () {// Navigate to second route when tapped.
                dataVonMarker();
              },
            ),
          ],
        ),
      ),
    );
  }
}

