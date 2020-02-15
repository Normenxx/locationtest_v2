import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'LocationMarker.dart';

class MapObjectManager {
  static  Set<Marker> markers;
  static  Set<Circle> circles;

  static void dataVonMarker(){
    //Debug Methode
    //Gibt daten über alle Locationmarker wieder

    for(LocationMarker m in MapObjectManager.markers){
      print("ID: " + m.markerId.toString() + " LatLng: " + m.position.toString() + "kreis:" + m.circle.circleId.toString());
    }
  }


}