import 'dart:collection';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:locationtest_v2/LocationMarkerManager.dart';
import 'LocationMarker.dart';


class googleMap extends StatefulWidget {

  googleMap({this.markers, this.circles});
  Set<Marker> markers;
  Set<Circle> circles;

  @override
  State <StatefulWidget> createState(){
    return _googleMapState(markers,circles);
  }

//
//  @override
//  _googleMapState createState() => _googleMapState();

}

class _googleMapState extends State<googleMap> {

  LatLng initialPosition = LatLng(47.412395, 9.742799);
  Set<Polyline> polylines = {};
  Set<Marker> markers;
  Set<Circle> circles;

  Position userCurrentPostion;


  _googleMapState(Set<Marker> markers,Set<Circle> circles){
    this.markers = markers;
    this.circles = circles;
  }

  void permissions() async {
    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
    print(geolocationStatus);
  }

  void position() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPostion = position;
    print(position);
  }

  Future<void> moveToPosition() async {
    CameraUpdate cameraUpdate = CameraUpdate.newLatLng(LatLng(userCurrentPostion.latitude,userCurrentPostion.longitude));
    googleMapController.moveCamera(cameraUpdate);
  }

  Future<void> inArea() async {
    double distanceInMeters;

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPostion = position;

    for(LocationMarker m in markers){
      distanceInMeters = await Geolocator().distanceBetween(userCurrentPostion.latitude, userCurrentPostion.longitude, m.currentPosition.latitude, m.currentPosition.longitude);
      print(distanceInMeters);
      if(distanceInMeters <=  m.circle.radius){
        print("Im Kreis" + m.markerId.toString());
        break;
      }
    }
    print("Nicht im Kreis");
  }

  void dataVonMarker(){
    for(LocationMarker m in markers){
      print("ID: " + m.markerId.toString() + " LatLng: " + m.currentPosition.toString());
    }
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
            initialCameraPosition: CameraPosition(target: initialPosition, zoom: 10),
            mapType: MapType.terrain,
            polylines: polylines,
            markers: markers,
            circles: circles,
            onMapCreated: (GoogleMapController googleMapController)
            {
              this.googleMapController = googleMapController;
            },
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

                        marker.currentPosition = latLng;
                      });
                    },
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationMarkerManager(locationMarker: marker, circles: circles,),
                        ),
                      );
                    }
                  );
                  setState(() {
                    markers.add(marker);
                    circles.add(marker.circle);
                  });
                },
              ),
//              RaisedButton(
//                child: Text("Rechte"),
//                onPressed: permissions,
//              ),
//              RaisedButton(
//                child: Text("Position"),
//                onPressed: position,
//              ),
//              RaisedButton(
//                child: Text("MoveToPosition"),
//                onPressed: moveToPosition,
//              ),
//              RaisedButton(
//                child: Text("InArea"),
//                onPressed: inArea,
//              ),
              RaisedButton(
                child: Text("dataVonMarker"),
                onPressed: dataVonMarker,
              )
            ],
            shrinkWrap: true,
          ),
        ]));
  }
}
