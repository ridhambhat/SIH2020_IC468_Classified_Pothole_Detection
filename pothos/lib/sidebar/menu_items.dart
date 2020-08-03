import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuItems extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuItems({Key key, this.icon, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      child: Row(children: <Widget>[
        Icon(icon,
          color:Colors.teal,
          size: 30,
        ),
        SizedBox(width: 70,),
        Text(title,style:TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 21,
          color: Colors.teal
        ))
      ],),
    );
  }
}
