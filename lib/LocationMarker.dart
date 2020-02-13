import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMarker extends Marker{
  Circle circle;
  static int _circleIdCounter = 0;

  LocationMarker({MarkerId markerid,LatLng position = const LatLng(0.0, 0.0), bool draggable = false, ValueChanged<LatLng> onDragEnd,  VoidCallback onTap}) : super(markerId: markerid, position:position,draggable:draggable,onDragEnd: onDragEnd, onTap: onTap) {
    _circleIdCounter++;
    circle = new Circle(
        circleId: new CircleId(_circleIdCounter.toString()),
        radius: 100,
        center: this.position,
        fillColor: Colors.red[50],
    );
    this.circle = circle;
}

}