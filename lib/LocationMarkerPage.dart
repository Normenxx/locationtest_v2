import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'LocationMarker.dart';
import 'MapObjectManager.dart';

class LocationMarkerPage extends StatefulWidget {

  LocationMarker locationMarker;

  LocationMarkerPage({LocationMarker locationMarker}){
    this.locationMarker = locationMarker;
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
          Text("ID:" + widget.locationMarker.markerId.toString()),
          Text("Postition:" + widget.locationMarker.position.toString()),
          Text("Kreis ID:" + widget.locationMarker.circle.circleId.toString()),
          Text("Kreis Radius:" + widget.locationMarker.circle.radius.toString()),
          Row(
            children: <Widget>[
              RaisedButton(
                 child: Text("+"),
                onPressed: (){
                   setState(() {

                     Circle oldCircle = widget.locationMarker.circle;
                     double newRadius = oldCircle.radius + 10;

                     Circle newCircle = oldCircle.copyWith(radiusParam: newRadius);

                     widget.locationMarker.circle = newCircle;
                     MapObjectManager.circles.remove(oldCircle);
                     MapObjectManager.circles.add(newCircle);
                   });
                },
              ),
              RaisedButton(
                child: Text("-"),
                onPressed: (){
                  setState(() {
                    Circle oldCircle = widget.locationMarker.circle;
                    double newRadius = oldCircle.radius - 10;

                    if(newRadius < 0){
                      newRadius = 0;
                    }
                    Circle newCircle = oldCircle.copyWith(radiusParam: newRadius);

                    widget.locationMarker.circle = newCircle;
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