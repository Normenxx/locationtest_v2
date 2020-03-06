import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locationtest_v2/utils/model/MapObjectManager.dart';
import 'package:locationtest_v2/utils/model/LocationMarker.dart';

class Attendance  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AttendanceState();
  }
}

class _AttendanceState extends State<Attendance> {
  Position _userCurrentPostion;
  Marker _markerOfUser;
  bool _atLocation = false;


  _AttendanceState(){
    updatePosition();
  }


  void updatePosition() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _userCurrentPostion = position;
    });
  }

  void inArea() async{
    double distanceInMeters;

    for (LocationMarker marker in MapObjectManager.markers) {
      distanceInMeters = await Geolocator().distanceBetween
        (
          _userCurrentPostion.latitude,
          _userCurrentPostion.longitude,
          marker.position.latitude,
          marker.position.longitude
        );
      if (distanceInMeters <= marker.circle.radius) {
        _atLocation = true;
        _markerOfUser = marker;
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
          Text("Anwesenheitbestätigt: " + _atLocation.toString()),
          Text("User Postition: " + _userCurrentPostion.toString()),
          if (_atLocation) Text("Marker ID : " + _markerOfUser.markerId.toString()),
          if (_atLocation) Text("Marker Postition : " + _markerOfUser.position.toString()),
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