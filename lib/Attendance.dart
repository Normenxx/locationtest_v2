import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'LocationMarker.dart';

class Attendance  extends StatefulWidget {
  Attendance({this.markers});
  Set<Marker> markers;

  @override
  State<StatefulWidget> createState() {
    return _AttendanceState(markers);
  }

}

class _AttendanceState extends State<Attendance> {
  Position userCurrentPostion;
  Set<Marker> markers;

  Marker markerOfUser;
  bool atLocation = false;

  _AttendanceState(Set<Marker> markers){
    this.markers = markers;
  }

  void position() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPostion = position;
  }

  Future<void> inArea() async {
    double distanceInMeters;

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPostion = position;

    for (LocationMarker marker in markers) {
      distanceInMeters = await Geolocator().distanceBetween
        (
          userCurrentPostion.latitude,
          userCurrentPostion.longitude,
          marker.position.latitude,
          marker.position.longitude
        );
      if (distanceInMeters <= marker.circle.radius) {
        atLocation = true;
        markerOfUser = marker;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Anwesenheit'),
      ),
      body: ListView(
        children: <Widget>[
          Text("Status: " + atLocation.toString()),
          Text("User Postition: " + userCurrentPostion.toString()),
          if (atLocation) Text("Marker ID : " + markerOfUser.markerId.toString()),
          if (atLocation) Text("Marker Postition : " + markerOfUser.position.toString()),
          RaisedButton(
            child: Text('Anwesenheitbestätigen'),
            onPressed: () {
              setState(() {
                inArea();
              });
            },
          ),
        ],
      ),
    );
  }
}