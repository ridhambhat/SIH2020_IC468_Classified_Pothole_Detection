import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pothos/sidebar/menu_items.dart';
import 'package:rxdart/subjects.dart';

import 'menu_items.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;

  final _animationduration = const Duration(milliseconds: 400);
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _animationduration);

    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isSidebarOpenedSink.close();
    isSidebarOpenedStreamController.close();
    _animationController.dispose();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenendAsync) {
        return AnimatedPositioned(
            duration: _animationduration,
            top: 0,
            bottom: 0,
            left: isSideBarOpenendAsync.data ? 0 : -screenwidth,
            right: isSideBarOpenendAsync.data ? 55 : screenwidth - 40,
            child: Row(
              children: <Widget>[
               
               
                Expanded(
                  child: Column(
                    children:<Widget>[
                    Container(color: Colors.teal,
                    width: 400,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
<<<<<<< HEAD
                        SizedBox(height: 200,),
                        Text("Hello Sayantanu", style: TextStyle(fontSize: 20),),
                        Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.white.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                        ),
                        MenuItems(icon: Icons.location_on,title: 'Drive',),
                        MenuItems(icon: Icons.map, title: 'Road Health Map'),
                        MenuItems(icon: Icons.directions_car,title: 'Car Status',),
                        MenuItems(icon: Icons.category,title: 'About',)
=======
                          
                            SizedBox(height: 70,),
                            CircleAvatar(
                              backgroundImage: AssetImage("assets/images/avatar.jpg"),
                              radius: 50,
                             ),
                            SizedBox(height: 20,),
                            Text("Jane Doe", style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.w600),),
                            SizedBox(height: 20,),
                            
                        
                        // SizedBox(height: 200,),
                        // Text("Hello Sayantanu"),
                        // Divider(
                        //     height: 64,
                        //     thickness: 0.5,
                        //     color: Colors.white.withOpacity(0.3),
                        //     indent: 32,
                        //     endIndent: 32,
                        // ),
                        // MenuItems(icon: Icons.location_on,title: 'Drive',),
                        // MenuItems(icon: Icons.directions_car,title: 'Car Status',),
                        // MenuItems(icon: Icons.category,title: 'About',)
                      ],
              )
                    ),

                    Expanded(
                      child:Container(color: Colors.white,
                    width: 400,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                          SizedBox(height: 20,),
                          Text("Your Contribution", style: TextStyle(color: Colors.teal, fontSize: 20,fontWeight: FontWeight.w500),),
                          Divider(
                            height: 24,
                            thickness: 1,
                            color: Colors.teal.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),
                          
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration:BoxDecoration(shape: BoxShape.circle,
                                  color: Colors.teal
                                  ),
                                 child:Icon(Icons.star,color: Colors.white,)
                                ),
                                SizedBox(width: 80,),
                                Text("Detected 30 potholes",style: TextStyle(color: Colors.teal, fontSize: 15,fontWeight: FontWeight.w500))

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration:BoxDecoration(shape: BoxShape.circle,
                                  color: Colors.teal
                                  ),
                                 child:Icon(Icons.star,color: Colors.white,)
                                ),
                                SizedBox(width: 80,),
                                Text("Scanned 100 Kms",style: TextStyle(color: Colors.teal, fontSize: 15,fontWeight: FontWeight.w500))

                              ],
                            ),
                            
                            SizedBox(height: 5,),
                            Row(
                              children: <Widget>[
                                Container(
                                  decoration:BoxDecoration(shape: BoxShape.circle,
                                  color: Colors.teal
                                  ),
                                 child:Icon(Icons.star,color: Colors.white,)
                                ),
                                SizedBox(width: 80,),
                                
                                Text("A+ Citizen",style: TextStyle(color: Colors.teal, fontSize: 15,fontWeight: FontWeight.w500))
                                
                              ],
                            ),
                            Divider(
                            height: 24,
                            thickness: 1,
                            color: Colors.teal.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child:Text("Quick Links",style: TextStyle(color: Colors.grey, fontSize: 17,fontWeight: FontWeight.w500)),
                          ),
                          MenuItems(
                            icon: Icons.person,
                            title: "Profile",
                          ),
                          MenuItems(
                            icon: Icons.settings,
                            title: "Settings",
                          ),
                          Divider(
                            height: 24,
                            thickness: 1,
                            color: Colors.teal.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),
                          

>>>>>>> a363d6d96a2eae5e7bc691277cb699fd6ad1813a
                      ],
              )
                    ))
                     ] )
                  
                  ),
                Align(
                    alignment: Alignment(0, -0.95),
                    child: GestureDetector(
                      onTap: () {
                        onIconPressed();
                      },
                      child: ClipPath(
                        clipper: CustomMenuClipper(),
                        child:Container(
                        alignment: Alignment.centerLeft,
                        width: 40,
                        height: 110,
                        color: Colors.teal,
                        child: AnimatedIcon(
                          progress: _animationController.view,
                          icon: AnimatedIcons.menu_close,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      )
                    ))
              ],
            ));
      },
    );
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