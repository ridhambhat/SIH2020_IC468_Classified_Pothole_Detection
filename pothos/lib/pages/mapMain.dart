import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/geolocation.dart';
import 'package:latlong/latlong.dart' as LatLong;

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

import 'package:pothos/pages/accelerometer.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:sensors/sensors.dart';
import 'package:oscilloscope/oscilloscope.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Timer timer;
  MapController _mapController = MapController();
  LatLong.LatLng _my = LatLong.LatLng(23.82, -23.45);

  bool qwe = true;

  double x = 0, y = 0, z = 0;
  List<double> ztrace = List();

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
       // pts.add(latLng);
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
   // pts.add(_my);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => DrawLines());

    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
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
            Polyline(points: pts, strokeWidth: 5.0, color: Colors.green),
            Polyline(points: pts2, strokeWidth: 5.0, color: Colors.red),
            Polyline(points: pts3, strokeWidth: 5.0, color: Colors.orange),
            Polyline(points: pts4, strokeWidth: 5.0, color: Colors.red),
            Polyline(points: pts5, strokeWidth: 5.0, color: Colors.green),
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    ztrace.add(z - 9.8);

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
        !_isSwitched
            ? Positioned(
                top: 750,
                right: 10,
                width: 70,
                height: 70,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _isSwitched = !_isSwitched;
                    });
                  },
                  child: Icon(Icons.directions_car),
                  backgroundColor: Colors.teal,
                ))
            : Container(
                width: 0,
                height: 0,
              ),
      ],
    );
  }

  Widget Accelerometer() {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    Oscilloscope oscilloscope = Oscilloscope(
      padding: 0.0,
      backgroundColor: Colors.white,
      traceColor: qwe ? Colors.greenAccent : Colors.redAccent,
      yAxisMax: 14.7,
      yAxisMin: -14.7,
      dataSet: ztrace,
    );

    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: screenwidth,
          height: screenheight * 0.35,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
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
                    Container(
                        width: screenwidth,
                        height: screenwidth * 0.2,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Center(child: oscilloscope))
                  ],
                ),
              ),
              Positioned(
                left: screenwidth - 100,
                top: 200,
                child: GestureDetector(
                    onTap: () => {
                          this.setState(() {
                            qwe = !qwe;
                          })
                        },
                    child: Container(
                      width: 80,
                      height: 80,
                      color: qwe ? Colors.white : Colors.redAccent,
                    )),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ));
  }

  var pts = <LatLong.LatLng>[
    LatLong.LatLng(28.417480, 77.327901),
    LatLong.LatLng(28.417827, 77.327866),
    LatLong.LatLng(28.417874, 77.328193),
    LatLong.LatLng(28.418120, 77.328166),
    LatLong.LatLng(28.418156, 77.327984),
    LatLong.LatLng(28.418142, 77.328016),
    LatLong.LatLng(28.418081, 77.327185),
    LatLong.LatLng(28.417185, 77.327233),
    LatLong.LatLng(28.416907, 77.327240),
    LatLong.LatLng(28.416881, 77.326848),
    LatLong.LatLng(28.416605, 77.326870),
  ];

  var pts2 = <LatLong.LatLng>[
        LatLong.LatLng(28.416612, 77.326865),
        LatLong.LatLng(28.416786, 77.330090)
  ];
  var pts3 = <LatLong.LatLng>[
        LatLong.LatLng(28.417480, 77.327901),
        LatLong.LatLng(28.417211, 77.327939),
        LatLong.LatLng(28.417213, 77.328221)
  ];
  var pts4 = <LatLong.LatLng>[
        LatLong.LatLng(28.417213, 77.328221),
        LatLong.LatLng(28.416970, 77.328245),
  ];

  var pts5 = <LatLong.LatLng>[
        LatLong.LatLng(28.416970, 77.328245),
        LatLong.LatLng(28.416923, 77.327239)
  ];

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
