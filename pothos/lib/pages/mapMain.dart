import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart' as LatLong;

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

import 'package:pothos/pages/accelerometer.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Timer timer;
  MapController _mapController = MapController();
  LatLong.LatLng _my = LatLong.LatLng(23.82, -23.45);
  var pts = <LatLong.LatLng>[];

  Widget _child;
  bool _isSwitched = false;
  bool _showBase = false;

  getPermission() async {
    final GeolocationResult result =
        await Geolocation.requestLocationPermission();
    return result;
  }

  getLocation() {
    getPermission().then((result) async {
      if (result.isSuccessful) {
        final coords =
            await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
        coords.listen((value) {
          if (value.isSuccessful) {
            setState(() {
              _my.latitude = value.location.latitude;
              _my.longitude = value.location.longitude;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void DrawLines() async {
    //print(pts);
    final coords =
        await Geolocation.currentLocation(accuracy: LocationAccuracy.best);
    coords.listen((event) {
      if (event.isSuccessful) {
        LatLong.LatLng latLng =
            LatLong.LatLng(event.location.latitude, event.location.longitude);
        pts.add(latLng);
        setState(() {
          _my = latLng;
          _mapController.move(_my, 18);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _child = SpinKitRipple(
      color: Colors.blueAccent,
    );
    getLocation();
    _child = getMap();
    pts.add(_my);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => DrawLines());
    super.initState();
  }

  Widget getMap() {
    return FlutterMap(
        mapController: _mapController,
        options: new MapOptions(
          center: _my,
          minZoom: 18.0,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/imsayantanu/ckdcc6u2z2zo81inx6t5jv60m/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaW1zYXlhbnRhbnUiLCJhIjoiY2tkY2MyYzBzMHdmMDJybXozeGowOWNxNyJ9.VNwOXTSl6WwCsNP-MSmtPg',
            additionalOptions: {
              'accessToken':
                  "pk.eyJ1IjoiaW1zYXlhbnRhbnUiLCJhIjoiY2tkY2MyYzBzMHdmMDJybXozeGowOWNxNyJ9.VNwOXTSl6WwCsNP-MSmtPg",
              'id': 'mapbox.mapbox-streets-v8'
            },
          ),
          new MarkerLayerOptions(markers: [
            new Marker(
                width: 45.0,
                height: 45.0,
                point: _my,
                builder: (context) => new Container(
                      child: IconButton(
                        icon: Icon(Icons.location_on),
                        color: Colors.blue,
                        iconSize: 45.0,
                        onPressed: () {
                          print('Marker tapped');
                        },
                      ),
                    ))
          ]),
          PolylineLayerOptions(polylines: [
            Polyline(points: pts, strokeWidth: 5.0, color: Colors.green)
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Flexible(child: _child),
            _isSwitched
                ? Accelerometer()
                : Container(
                    width: 0,
                    height: 0,
                  )
          ],
        ),
        Positioned(
            top: 20,
            right: 0,
            child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                        alignment: Alignment.centerRight,
                        width: 55,
                        height: 110,
                        color: Colors.teal,
                        child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Switch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                              activeTrackColor: Colors.amberAccent,
                              activeColor: Colors.amber,
                            )))))),
      ],
    );
  }

  Widget Accelerometer() {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: screenwidth,
          height: screenheight * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Driving Mode',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.drive_eta,
                      size: 40,
                      color: Colors.teal,
                    ),
                  ],
                ),
                Divider(
                  height: 14,
                  thickness: 1,
                  color: Colors.teal.withOpacity(0.3),
                  indent: 32,
                  endIndent: 32,
                ),
                AccelerometerPage()
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ));
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
