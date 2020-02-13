import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:locationtest_v2/LocationMarkerManager.dart';
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
  Set<Polyline> polylines = {};
  Set<Marker> markers;
  Set<Circle> circles;

  Position userCurrentPostion;

  _MapState(Set<Marker> markers, Set<Circle> circles) {
    this.markers = markers;
    this.circles = circles;
  }

  void recreateMarkers(Set<Marker> markers){
    Set<Marker> newMarkers = {};
    for(LocationMarker m in markers){
      LocationMarker newMarker = createLocationMarker(m.position);
      newMarkers.add(newMarker);
    }

    newMarkers;
  }

  void permissions() async {
    GeolocationStatus geolocationStatus =
        await Geolocator().checkGeolocationPermissionStatus();
    print(geolocationStatus);
  }

  void position() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentPostion = position;
    print(position);
  }

  Future<void> moveToPosition() async {
    CameraUpdate cameraUpdate = CameraUpdate.newLatLng(
        LatLng(userCurrentPostion.latitude, userCurrentPostion.longitude));
    googleMapController.moveCamera(cameraUpdate);
  }

  LocationMarker createLocationMarker(LatLng initalPostion){
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
              builder: (context) => LocationMarkerManager(
                locationMarker: marker,
                circles: circles,
              ),
            ),
          );
        });
    return marker;
  }

  void dataVonMarker(){
    for(LocationMarker m in markers){
      print("ID: " + m.markerId.toString() + " LatLng: " + m.position.toString() + "kreis:" + m.circle.circleId.toString());
      if(m is LocationMarker)
        print("Ist ein LocationMarker");

      if(m is Marker)
        print("Ist ein Marker");

      if(m.onDragEnd == null){
        print("Function ist null");
      }
    }
  }

  void locationMarkerOnDragEnd(LatLng latLng, LocationMarker oldMarker) {
    //Erstellen eines neuen Markers
    LocationMarker marker = createLocationMarker(latLng);

    /*
    Problem hier
    Beschreibung: Wenn man einen Marker auf Google Map setzt zurück geht und wieder zurück geht wird alles in setstate() nicht mehr ausgeführt.
    Beim ersten mal geht das setstate() jedoch
     */
    setState(() {
      print("SetState");
      circles.remove(oldMarker.circle);
      markers.remove(oldMarker);

      circles.add(marker.circle);
      markers.add(marker);
    });
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
            polylines: polylines,
            markers: markers,
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
                    markers.add(marker);
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
                    markers.add(marker);
                  });
                },
              ),
              RaisedButton(
                child: Text("dataVonMarker"),
                onPressed: dataVonMarker,
              ),
            ],
            shrinkWrap: true,
          ),
        ]));
  }
}
