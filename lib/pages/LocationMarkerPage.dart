import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:locationtest_v2/utils/model/LocationMarker.dart';
import 'package:locationtest_v2/utils/model/MapObjectManager.dart';

class LocationMarkerPage extends StatefulWidget {

  LocationMarker _locationMarker;

  LocationMarkerPage({LocationMarker locationMarker}){
    this._locationMarker = locationMarker;
  }

  @override
  _LocationMarkerPageState createState() => _LocationMarkerPageState();
}

class _LocationMarkerPageState extends State<LocationMarkerPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Marker'),
      ),
      body: ListView(
        children: <Widget>[
          Text("ID:" + widget._locationMarker.markerId.toString()),
          Text("Postition:" + widget._locationMarker.position.toString()),
          Text("Kreis ID:" + widget._locationMarker.circle.circleId.toString()),
          Text("Kreis Radius:" + widget._locationMarker.circle.radius.toString()),
          Row(
            children: <Widget>[
              RaisedButton(
                 child: Text("+"),
                onPressed: (){
                   setState(() {

                     Circle oldCircle = widget._locationMarker.circle;
                     double newRadius = oldCircle.radius + 10;

                     Circle newCircle = oldCircle.copyWith(radiusParam: newRadius);

                     widget._locationMarker.circle = newCircle;
                     MapObjectManager.circles.remove(oldCircle);
                     MapObjectManager.circles.add(newCircle);
                   });
                },
              ),
              RaisedButton(
                child: Text("-"),
                onPressed: (){
                  setState(() {
                    Circle oldCircle = widget._locationMarker.circle;
                    double newRadius = oldCircle.radius - 10;

                    if(newRadius < 0){
                      newRadius = 0;
                    }
                    Circle newCircle = oldCircle.copyWith(radiusParam: newRadius);

                    widget._locationMarker.circle = newCircle;
                    MapObjectManager.circles.remove(oldCircle);
                    MapObjectManager.circles.add(newCircle);
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}