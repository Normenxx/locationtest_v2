import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'LocationMarker.dart';


class googleMap extends StatefulWidget {
  @override
  _googleMapState createState() => _googleMapState();
}

class _googleMapState extends State<googleMap> {
  LatLng initialPosition = LatLng(47.412395, 9.742799);
  final Set<Polyline> polylines = {};
  final Set<Marker> markers = {};
  final Set<Circle> circles = {};

  Function rip(LatLng test) {
    print("Verschoben" + test.toString());
  }

  GoogleMapController googleMapController;
  static int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google Map'),
        ),
        body: Stack(children: <Widget>[
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: initialPosition, zoom: 10),
            mapType: MapType.terrain,
            polylines: polylines,
            markers: markers,
            circles: circles,
          ),
          ListView(
            children: <Widget>[
              RaisedButton(
                child: Text("Add Location Marker"),
                onPressed: () {
                  counter++;
                  LocationMarker marker;
                  marker = new LocationMarker(
                    markerid: new MarkerId(counter.toString()),
                    position: LatLng(47.412395, 9.742799),
                    draggable: true,
                    onDragEnd: (LatLng latLng){
                      setState(() {
                        Circle oldCircle =  marker.circle;
                        Circle newCircle = new Circle(
                          circleId: oldCircle.circleId,
                          radius: oldCircle.radius,
                          center: latLng,
                          fillColor: oldCircle.fillColor,
                          onTap: oldCircle.onTap
                        );

                        circles.remove(oldCircle);
                        marker.circle = newCircle;
                        circles.add(newCircle);
                      });
                    },
                  );


                  setState(() {
                    markers.add(marker);
                    circles.add(marker.circle);
                  });
                },
              ),
            ],
            shrinkWrap: true,
          ),
        ]));
  }
}
