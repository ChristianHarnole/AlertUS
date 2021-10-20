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

class rtpcrScreen extends StatefulWidget {
  const rtpcrScreen({Key? key}) : super(key: key);

  @override
  _rtpcrScreenState createState() => _rtpcrScreenState();
}

class _rtpcrScreenState extends State<rtpcrScreen> {
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  late LocationData currentLocation;
  late LatLng destinationLocation;
  late int distance = 0;
  late String name = "";
  List<String> rtpcrstation_names = [
    "High-Precision Diagnostics\nAddress: McArthur Hi-Way Corner Angeles Magalang\nContact: (045) 322 2211",
    "Angeles  University Foundation Medical Center\nAddress: MacArthur Hwy, Angeles, Pampanga\nContact: (045) 625 2999",
    "AC Sacred Heart Medical Centerr\nAddress: MacArthur Hwy, Angeles, Pampanga\nContact: (045) 624 5606",
    "Rafael Lazatin Memorial Medical Center (ONA)\nAddress: Visitacion St, Angeles, Pampanga\nContact: 0998 282 6259",
    "St. Catherine Of Alexandria Foundation and Medical Center\nAddress: Lot 5-6 Block 13 Rizal Extension, Brgy. Cutcut, Angeles, Pampanga\nContact: (045) 888 7209",
    "St. Catherine of Alexandria Foundation & Medical Center (New Site)\nAddress: Lot 5-6 Block 13 Rizal Extension, Angeles, Pampanga\nContact: 09189481097",
    "PRI Medical Center\nAddress: Arayat Boulevard, Angeles, Pampanga\nContact: 0917 180 8886",
    "Holy Family Medical Center\nAddress: 1377 Santo Entiero St, Angeles, Pampanga\nContact: (045) 322 3623",
    "Dr. Armando Garcia Hospital\nAddress: 2196 Agapito Del Rosario Street, Angeles, Pampanga\nContact: 0918 935 1052"
        "Avanti Care Diagnostic Center\nAddress: 2401 Surla Street, Balibago, Angeles, Pampanga\nContact: 09352367728",
    "SAVEPOINT (Sanitary Anti-Viral Entry Point)\nAddress: A-line Apartments, S. Rivera Lim, Balibago\nContact:\n+639565290826\n+639994633199",
    "Astroclark Diagnostics Center\nAddress: 105 Zeppelin St, Balibago, Angeles, Pampanga\nContact: 0963 995 7107",
    "Quest Phil Diagnostics\nAddress: Salome St, Angeles, Pampanga\nContact:\n0917-626-0911\n0917-535-9417\n0925-577-8378",
    "Acemed Diagnostic Laboratory\nAddress: Teodoro St., Angeles City\nContact:\n0917 798 9993\n0999 888 7926",
    "Singapore Diagnostics\nAddress: MacArthur Highway, San Pablo St, Angeles, Pampanga\nContact: 0917 709 1577",
    "Mdlab Diagnostic Center, Inc.\nAddress: Lot 23, Block 11, 1st Street, Balibago, Angeles City\nContact:\n(045) 458 2614\n09324200799\n09334762398"
  ];
  List<LatLng> rtpcrstation_coords = [
    LatLng(15.14254577166236, 120.59682727391306),
    LatLng(15.14495233730257, 120.59516448904672),
    LatLng(15.125306530209052, 120.59842180655338),
    LatLng(15.146001593120932, 120.58068345819663),
    LatLng(15.135189694809903, 120.58521014540165),
    LatLng(15.13035330326567, 120.57623313720151),
    LatLng(15.14851942816395, 120.57683634504241),
    LatLng(15.140007981279414, 120.59432371185119),
    LatLng(15.142934874169612, 120.58908083488784),
    LatLng(15.165192845709853, 120.58991279977297),
    LatLng(15.16046680625337, 120.59225766471185),
    LatLng(15.167949368722192, 120.58882641915899),
    LatLng(15.156766265172866, 120.59182809921151),
    LatLng(15.166552871769241, 120.58464912646126),
    LatLng(15.1474675958681, 120.59377375000999),
    LatLng(15.169326153480457, 120.58698711633322),
  ];

  var location = new Location();
  var userLocation;

  void shortestDistance() async {
    currentLocation = await location.getLocation();
    double dist;
    for (int i = 0; i <= 15; i++) {
      dist = await Geolocator.distanceBetween(
          rtpcrstation_coords[i].latitude,
          rtpcrstation_coords[i].longitude,
          currentLocation.latitude,
          currentLocation.longitude);
      abc.add(dist);
    }
    double nearest = abc.reduce(min);
    int j = abc.indexOf(nearest);
    destinationLocation = LatLng(
        rtpcrstation_coords[j].latitude, rtpcrstation_coords[j].longitude);

    distance = nearest.toInt();
    name = rtpcrstation_names[j];
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
  }

  void setSourceAndDestinationLocationMarkerIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/origin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/destination.png');
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(15.169326153480457, 120.58698711633322));

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
                    Icons.coronavirus_rounded,
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
