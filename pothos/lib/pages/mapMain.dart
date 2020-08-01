import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;

import 'package:pothos/pages/accelerometer.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';



class AddPolylines extends StatefulWidget {
  @override
  _AddPolylinesState createState() => _AddPolylinesState();
}
class _AddPolylinesState extends State<AddPolylines> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  LatLng _lastMapPosition = _center;
  List<LatLng> latlng = [
    LatLng(45.521563, -122.677433),
    LatLng(45.521563, -123.677433),
    LatLng(46.521563, -123.677433),

  ];
  MapType _currentMapType = MapType.normal;
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Custom Marker',
          snippet: 'Inducesmile.com',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _polylines.add(Polyline(
        polylineId: PolylineId('poly'),
        visible: true,
        points: latlng,
        color: Colors.red,
      ));
    });
  }
  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add Polyline Google Maps'),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              polylines: _polylines,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget> [
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   GoogleMapController _controller;
//   Position position;
//   Widget _child;
//   bool _isSwitched = false;
//   bool _showBase = false;


//   @override
//   void initState() {
//     // TODO: implement initState
//     _child = SpinKitRipple(color: Colors.blueAccent,);
//     getCurrentLocation();
//     super.initState();

//   }

//   void getCurrentLocation() async {
//     Position res = await Geolocator().getCurrentPosition();
//     setState(() {
//       position = res;
//       _child = mapWidget();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         Column(
//           children: <Widget>[Flexible(child:_child),_isSwitched?Accelerometer():Container(width: 0,height: 0,)],
//         ),


//         Positioned(
//           top: 20,
//           right: 0,
//           child: Transform(
//             alignment: Alignment.center,
//             transform: Matrix4.rotationY(math.pi),
//             child:ClipPath(
//             clipper: CustomMenuClipper(),
//             child: Container(
//               alignment: Alignment.centerRight,
//                width: 55,
//                height: 110,
//                color: Colors.teal,
//                child: Transform(
//                   alignment: Alignment.center,
//                   transform: Matrix4.rotationY(math.pi),
//                   child:Switch(
//                     value: _isSwitched,
//                     onChanged: (value) {
//                     setState(() {
//                       _isSwitched = value;
//                      });
//                     },
//                     activeTrackColor: Colors.amberAccent,
//                     activeColor: Colors.amber,
//                   )

//             )
//           ))
//         )),


//       ],
//     );
//   }

//   Widget mapWidget() {
//     return GoogleMap(
//       mapType: MapType.normal,
//       markers: _createMarker(),
//       initialCameraPosition: CameraPosition(
//           target: LatLng(position.latitude, position.longitude), zoom: 12.0),
//       onMapCreated: (GoogleMapController controller) {
//         _controller = controller;
//       },
//     );
//   }

//   Set<Marker> _createMarker() {
//     return <Marker>[
//       Marker(
//           markerId: MarkerId("home"),
//           position: LatLng(position.latitude, position.longitude),
//           icon: BitmapDescriptor.defaultMarker,
//           infoWindow: InfoWindow(title: "Home"))
//     ].toSet();
//   }

//   Widget Accelerometer(){
//     final screenwidth = MediaQuery.of(context).size.width;
//     final screenheight = MediaQuery.of(context).size.height;
//     return Align(
//       alignment: Alignment.bottomCenter,

//       child: Container(
//           width: screenwidth,
//           height: screenheight*0.3,
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text('Driving Mode', style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 25,
//                       fontWeight: FontWeight.w900

//                     ),),
//                     SizedBox(width: 30,),
//                     Icon(
//                       Icons.drive_eta,
//                       size: 40,
//                       color: Colors.teal,
//                     ),

//                   ],
//                 ),
//                 Divider(
//                   height: 14,
//                   thickness: 1,
//                   color: Colors.teal.withOpacity(0.3),
//                   indent: 32,
//                   endIndent: 32,
//                 ),
//                 AccelerometerPage()
//               ],
//             ),
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//       )
//     );
//   }


// }

// class CustomMenuClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Paint paint = Paint();
//     paint.color = Colors.white;

//     final width = size.width;
//     final height = size.height;

//     Path path = Path();
//     path.moveTo(0, 0);
//     path.quadraticBezierTo(0, 8, 10, 16);
//     path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
//     path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
//     path.quadraticBezierTo(0, height - 8, 0, height);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }