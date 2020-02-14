import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:locationtest_v2/LocationMarkerManager.dart';
import 'package:locationtest_v2/LocationMarkerPage.dart';
import 'LocationMarker.dart';

class Map extends StatefulWidget {
  Map({this.markers, this.circles});

  Set<Marker> markers;
  Set<Circle> circles;

  @override
  State<StatefulWidget> createState() {
    return _MapState(markers, circles);
  }
}

class _MapState extends State<Map> {
  LatLng initialPosition = LatLng(47.412395, 9.742799);
  Set<Circle> circles;

  Position userCurrentPostion;

  _MapState(Set<Marker> markers, Set<Circle> circles) {
    recreateMarkers(LocationMarkerManager.markers);
  }

  LocationMarker createLocationMarker(LatLng initalPostion){
    //Factory Methode
    counter++;
    LocationMarker marker;
    marker = new LocationMarker(
        markerid: new MarkerId(counter.toString()),
        position: initalPostion,
        draggable: true,
        onDragEnd: (LatLng latLng) {
          locationMarkerOnDragEnd(latLng, marker);
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationMarkerPage(
                locationMarker: marker,
                circles: circles,
              ),
            ),
          );
        });
    return marker;
  }

  void locationMarkerOnDragEnd(LatLng latLng, LocationMarker oldMarker) {
    //Hilfsmethode für die Factory Methode
    LocationMarker marker = createLocationMarker(latLng);

    setState(() {
      circles.remove(oldMarker.circle);
      LocationMarkerManager.markers.remove(oldMarker);

      circles.add(marker.circle);
      LocationMarkerManager.markers.add(marker);
    });
  }

  void recreateMarkers(Set<Marker> markers){
    //Löst das Problem von locationMarkerOnDragEnd mit setState
    //Erstellt die Marker neu

    if(markers == null){
      markers = {};
    }

    circles = {};

    Set<Marker> newMarkers = {};
    for(LocationMarker m in markers){
      LocationMarker newMarker = createLocationMarker(m.position);
      newMarkers.add(newMarker);
      circles.add(newMarker.circle);
    }
    LocationMarkerManager.markers = newMarkers;
  }

  void permissions() async {
    //Debug Methode
    //Gibt an ob man Rechte für die Location hat
    GeolocationStatus geolocationStatus = await Geolocator().checkGeolocationPermissionStatus();
    print(geolocationStatus);
  }

  void position() async {
    //Debug Methode
    //Gibt die Momentanige Position an
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  Future<void> moveToPosition() async {
    //Debug Methode
    //Verschiebt die Kamera zu einer neuen position
    CameraUpdate cameraUpdate = CameraUpdate.newLatLng(initialPosition);
    googleMapController.moveCamera(cameraUpdate);
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
            markers: LocationMarkerManager.markers,
            circles: circles,
            onMapCreated: (GoogleMapController googleMapController) {
              this.googleMapController = googleMapController;
            },
          ),
          ListView(
            children: <Widget>[
              RaisedButton(
                child: Text("Add Location Marker"),
                onPressed: () {
                  LocationMarker marker = createLocationMarker(LatLng(47.412395, 9.742799));
                  setState(() {
                    LocationMarkerManager.markers.add(marker);
                    circles.add(marker.circle);
                  });
                },
              ),
              RaisedButton(
                child: Text("(Debug) Add User Location Marker"),
                onPressed: () async {
                  await position();

                  LocationMarker marker = createLocationMarker(LatLng(userCurrentPostion.latitude,userCurrentPostion.longitude));
                  setState(() {
                    LocationMarkerManager.markers.add(marker);
                  });
                },
              ),
              RaisedButton(
                child: Text("(Debug) dataVonMarker"),
                onPressed: (){
                  LocationMarkerManager.dataVonMarker();
                },
              ),
            ],
            shrinkWrap: true,
          ),
        ]));
  }
}
