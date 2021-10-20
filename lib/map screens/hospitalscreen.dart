import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
List<double> abc = [];
Set<Polyline> _polylines = Set<Polyline>();
List<LatLng> polylineCoordinates = [];
late PolylinePoints polylinePoints;

String googleAPIKey = "AIzaSyDmHM-IakxXdJqN59m-rYM-nBjQueCDam8";

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({Key? key}) : super(key: key);

  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  late LocationData currentLocation;
  late LatLng destinationLocation;
  late int distance = 0;
  late String name = "";
  List<String> hospital_names = [
    "Angeles  University Foundation Medical Center\nAddress: MacArthur Hwy, Angeles, Pampanga\nContact: (045) 625 2999",
    "AC Sacred Heart Medical Centerr\nAddress: MacArthur Hwy, Angeles, Pampanga\nContact: (045) 624 5606",
    "Rafael Lazatin Memorial Medical Center (ONA)\nAddress: Visitacion St, Angeles, Pampanga\nContact: 0998 282 6259",
    "St. Catherine Of Alexandria Foundation and Medical Center\nAddress: Lot 5-6 Block 13 Rizal Extension, Brgy. Cutcut, Angeles, Pampanga\nContact: (045) 888 7209",
    "St. Catherine of Alexandria Foundation & Medical Center (New Site)\nAddress: Lot 5-6 Block 13 Rizal Extension, Angeles, Pampanga\nContact: 09189481097",
    "PRI Medical Center\nAddress: Arayat Boulevard, Angeles, Pampanga\nContact: 0917 180 8886",
    "Angeles Medical Center Inc\nnAddress: 641 Rizal St, Angeles, Pampanga\nContact: (045) 322 4632",
    "Holy Family Medical Center\nAddress: 1377 Santo Entiero St, Angeles, Pampanga\nContact: (045) 322 3623",
    "Dr. Armando Garcia Hospital\nAddress: 2196 Agapito Del Rosario Street, Angeles, Pampanga\nContact: 0918 935 1052"
  ];
  List<LatLng> hospital_coords = [
    LatLng(15.1449209217148, 120.595218414368),
    LatLng(15.125289439301163, 120.59840279403662),
    LatLng(15.146012086166653, 120.58067588839987),
    LatLng(15.13966511552431, 120.57912344929788),
    LatLng(15.130718548831034, 120.57634686085967),
    LatLng(15.14851942816395, 120.57683634504241),
    LatLng(15.141575551927525, 120.58931023345939),
    LatLng(15.140007981279414, 120.59432371185119),
    LatLng(15.142934874169612, 120.58908083488784)
  ];

  var location = new Location();
  var userLocation;

  void shortestDistance() async {
    currentLocation = await location.getLocation();
    double dist;
    for (int i = 0; i <= 8; i++) {
      //LatLng xyz = hospital_coords[i];
      dist = await Geolocator.distanceBetween(
          hospital_coords[i].latitude,
          hospital_coords[i].longitude,
          currentLocation.latitude,
          currentLocation.longitude);
      abc.add(dist);
    }
    double nearest = abc.reduce(min);
    int j = abc.indexOf(nearest);
    destinationLocation =
        LatLng(hospital_coords[j].latitude, hospital_coords[j].longitude);

    distance = nearest.toInt();
    name = hospital_names[j];
  }

  void initState() {
    shortestDistance();
    super.initState();
    location = new Location();
    polylinePoints = PolylinePoints();
    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      updatePinOnMap();
    });
    setSourceAndDestinationLocationMarkerIcons();
    //setInitialLocation();
  }

  void setSourceAndDestinationLocationMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/origin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/destination.png');
  }

  // void setInitialLocation() async {
  //   currentLocation = await location.getLocation();
  // }
  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(0, 0));

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Map",
          ),
          backgroundColor: Colors.redAccent[700],
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: GoogleMap(
              myLocationEnabled: false,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              polylines: _polylines,
              markers: _markers,
              mapType: MapType.terrain,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                shortestDistance();
                showPinsOnMap();
              },
            )),
            Positioned(top: 40, left: 0, right: 0, child: MapUserBadge()),
            Positioned(
                left: 0, right: 0, bottom: 20, child: MapDestBadge(name: name))
          ],
        ));
  }

  void showPinsOnMap() {
    setState(() {
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition,
          icon: sourceIcon));
      _markers.add(Marker(
          markerId: MarkerId('destinationPin'),
          position: destinationLocation,
          icon: destinationIcon));
      setPolylines();
    });
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDmHM-IakxXdJqN59m-rYM-nBjQueCDam8",
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(
            destinationLocation.latitude, destinationLocation.longitude));
    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {
        _polylines.add(Polyline(
            width: 10,
            polylineId: PolylineId('Polyline'),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(currentLocation.latitude, currentLocation.longitude));
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition,
          icon: sourceIcon));
    });
  }
}

class MapDestBadge extends StatelessWidget {
  const MapDestBadge({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset.zero)
            ]),
        child: Row(
          children: [
            Stack(
              children: [
                ClipOval(
                  child: Icon(
                    Icons.local_hospital_rounded,
                    size: 50.0,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
            ),
            Icon(Icons.location_pin, color: Colors.red, size: 50)
          ],
        ));
  }
}

var currentUser = FirebaseAuth.instance.currentUser;
var email = currentUser.email;

class MapUserBadge extends StatelessWidget {
  const MapUserBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset.zero)
            ]),
        child: Row(
          children: [
            Container(
              width: 0,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.person_pin,
              size: 50.0,
              color: Colors.green,
            ),
            SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(email,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ])),
            Icon(Icons.location_pin, color: Colors.green, size: 40)
          ],
        ));
  }
}
