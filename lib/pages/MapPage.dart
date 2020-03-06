import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:locationtest_v2/utils/model/MapObjectManager.dart';
import 'package:locationtest_v2/utils/model/LocationMarker.dart';
import 'package:locationtest_v2/pages//LocationMarkerPage.dart';

class Map extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends State<Map> {
  LatLng _initialPosition = LatLng(47.412395, 9.742799);

  Position _userCurrentPostion;

  _MapState() {
    recreateMarkers(MapObjectManager.markers);
  }

  LocationMarker createLocationMarker(LatLng initalPostion, {double circleradius}){
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
        circleRadius: circleradius,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LocationMarkerPage(
                locationMarker: marker,
              ),
            ),
          );
        });
    return marker;
  }

  void locationMarkerOnDragEnd(LatLng latLng, LocationMarker oldMarker) {
    //Hilfsmethode für die Factory Methode
    LocationMarker marker = createLocationMarker(latLng,circleradius: oldMarker.circle.radius);

    setState(() {
      MapObjectManager.circles.remove(oldMarker.circle);
      MapObjectManager.markers.remove(oldMarker);

      MapObjectManager.circles.add(marker.circle);
      MapObjectManager.markers.add(marker);
    });
  }

  void recreateMarkers(Set<Marker> markers){
    //Löst das Problem von locationMarkerOnDragEnd mit setState
    //Erstellt die Marker neu

    if(markers == null){
      markers = {};
    }

    MapObjectManager.circles = {};

    Set<Marker> newMarkers = {};
    for(LocationMarker m in markers){
      LocationMarker newMarker = createLocationMarker(m.position);
      newMarker.circle = m.circle;
      newMarkers.add(newMarker);
      MapObjectManager.circles.add(newMarker.circle);
    }
    MapObjectManager.markers = newMarkers;
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
    CameraUpdate cameraUpdate = CameraUpdate.newLatLng(_initialPosition);
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
                CameraPosition(target: _initialPosition, zoom: 10),
            mapType: MapType.terrain,
            markers: MapObjectManager.markers,
            circles: MapObjectManager.circles,
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
                    MapObjectManager.markers.add(marker);
                    MapObjectManager.circles.add(marker.circle);
                  });
                },
              ),
              RaisedButton(
                child: Text("(Debug) Add User Location Marker"),
                onPressed: () async {
                  await position();

                  LocationMarker marker = createLocationMarker(LatLng(_userCurrentPostion.latitude,_userCurrentPostion.longitude));
                  setState(() {
                    MapObjectManager.markers.add(marker);
                  });
                },
              ),
              RaisedButton(
                child: Text("(Debug) dataVonMarker"),
                onPressed: (){
                  MapObjectManager.dataVonMarker();
                },
              ),
            ],
            shrinkWrap: true,
          ),
        ]));
  }
}
