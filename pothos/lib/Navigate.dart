import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';

class myNavigator extends StatefulWidget {
  @override
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<myNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Let's go"),backgroundColor: Colors.teal,),
      body:SingleChildScrollView(
        child:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: <Widget>[
            TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                    Icons.search,
                    color: Colors.teal,
                  ),
              enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                         color: Colors.teal, width: 1,
                      )
                      )
            ),
          ),
          SizedBox(height: 40,),
          Row(
            children: <Widget>[
              GestureDetector(
              onTap: ()=>{
                Navigator.popAndPushNamed(context,
                        '/main')
              },
              child:Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.teal
                ),
                child: Icon(
                  Icons.directions_car,
                  size: 50,
                  color: Colors.white,
                ),
              ),),
              SizedBox(width: 30,),
              GestureDetector(
              onTap: ()=>{
                Navigator.popAndPushNamed(context,
                        '/main')
              },
              child:Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.teal
                ),
                child: Icon(
                  Icons.directions_bus,
                  size: 50,
                  color: Colors.white,
                ),
              ),),
              SizedBox(width: 30,),
              GestureDetector(
              onTap: ()=>{
                Navigator.popAndPushNamed(context,
                        '/main')
              },
              child:Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.teal
                ),
                child: Icon(
                  Icons.directions_car,
                  size: 50,
                  color: Colors.white,
                ),
              ),)
            ],
          ),
          SizedBox(height: 40,),
          SafeArea(
          child:Image.asset(
            
            'assets/images/map.png',
            width: 500,
            height: 400,
            scale: 2,
          ))
          ]),
        ),
      ),
    ));
  }
}
