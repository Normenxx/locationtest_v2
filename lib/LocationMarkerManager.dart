import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'LocationMarker.dart';

class LocationMarkerManager {
  static  Set<Marker> markers;

  static void dataVonMarker(){
    //Debug Methode
    //Gibt daten über alle Locationmarker wieder

    for(LocationMarker m in LocationMarkerManager.markers){
      print("ID: " + m.markerId.toString() + " LatLng: " + m.position.toString() + "kreis:" + m.circle.circleId.toString());
    }
  }


}