import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMarker extends Marker{
  Circle _circle;
  static int _circleIdCounter = 0;

  LocationMarker({MarkerId markerid,LatLng position = const LatLng(0.0, 0.0), bool draggable = false, ValueChanged<LatLng> onDragEnd,  VoidCallback onTap, double circleRadius}) : super(markerId: markerid, position:position,draggable:draggable,onDragEnd: onDragEnd, onTap: onTap) {
    _circleIdCounter++;

    if(circleRadius==null){
      circleRadius = 100;
    }

    _circle = new Circle(
        circleId: new CircleId(_circleIdCounter.toString()),
        radius: circleRadius,
        center: this.position,
        fillColor: Colors.red[50],
    );
    this._circle = _circle;
  }

  Circle get circle => _circle;

  set circle(Circle value) {
    _circle = value;
  }

}