import 'package:flutter/material.dart';
import 'package:locationtest_v2/LocationMarkerPage.dart';

import 'LocationMarker.dart';
import 'MapObjectManager.dart';

class LocationListPage  extends StatefulWidget {
  @override
  _LocationListPageState createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  List<RaisedButton> _markerListe = new List<RaisedButton>();

  List<Widget> _buildMarkerListe() {
    if(MapObjectManager.markers == null){
      MapObjectManager.markers = {};
    }
    for(LocationMarker m in MapObjectManager.markers){
      _markerListe.add(
          new RaisedButton(
              child: Text("Marker" + m.markerId.toString()),
              onPressed:   (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationMarkerPage(locationMarker: m,)
                    ));
                },
          )
      );
    }
    return _markerListe;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Markerliste'),
      ),
      body: ListView(
        children: _buildMarkerListe(),
      ),
    );
  }
}