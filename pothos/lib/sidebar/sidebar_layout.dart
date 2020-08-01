import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'sidebar.dart';
import 'package:pothos/pages/mapMain.dart';


class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: <Widget>[AddPolylines(), SideBar()],
      )
    );
  }
}
//MapPage(), SideBar()