import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:locationtest_v2/utils/model/LocationMarker.dart';



class MapObjectManager {
  static  Set<Marker> _markers;
  static  Set<Circle> _circles;

  static void dataVonMarker(){
    //Debug Methode
    //Gibt daten über alle Locationmarker wieder

    for(LocationMarker m in MapObjectManager.markers){
      print("ID: " + m.markerId.toString() + " LatLng: " + m.position.toString() + "kreis:" + m.circle.circleId.toString());
    }
  }

  static Set<Circle> get circles => _circles;

  static set circles(Set<Circle> value) {
    _circles = value;
  }

  static Set<Marker> get markers => _markers;

  static set markers(Set<Marker> value) {
    _markers = value;
  }


}