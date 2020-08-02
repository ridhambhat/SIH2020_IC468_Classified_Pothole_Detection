import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sensors/sensors.dart';
import 'package:oscilloscope/oscilloscope.dart';

class AccelerometerPage extends StatefulWidget {
  @override
  _AccelerometerPageState createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {

  double x =0 , y = 0, z = 0;
  List<double> ztrace = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    ztrace.add(z-9.8);
    Oscilloscope oscilloscope = Oscilloscope(
      padding: 0.0,
      backgroundColor: Colors.white,
      traceColor: Colors.amber,
      yAxisMax: 14.7,
      yAxisMin: -14.7,
      dataSet: ztrace,

    );
    return Container(
      width: screenwidth,
      height: screenwidth*0.2,
      padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
      child:Center(
          child:oscilloscope
      )
    );
  }
}
