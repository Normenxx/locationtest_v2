import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'LocationMarker.dart';

class LocationMarkerManager extends StatefulWidget {


  LocationMarker locationMarker;
  Set<Circle> circles = {};

  LocationMarkerManager({LocationMarker locationMarker,  Set<Circle> circles}){
    this.locationMarker = locationMarker;
    this.circles = circles;
  }

  @override
  _LocationMarkerManagerState createState() => _LocationMarkerManagerState();
}

class _LocationMarkerManagerState extends State<LocationMarkerManager> {
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
          Text("Erstellt an Postition:" + widget.locationMarker.position.toString()),
          Text("Aktuelle Postition:" + widget.locationMarker.currentPosition.toString()),
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
                     widget.circles.remove(oldCircle);
                     widget.circles.add(newCircle);
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
                    widget.circles.remove(oldCircle);
                    widget.circles.add(newCircle);
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