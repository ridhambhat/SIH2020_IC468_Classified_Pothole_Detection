import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _mobilenumber = TextEditingController();
    TextEditingController _vehicle = TextEditingController();
    

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 10),
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                color: Colors.blueAccent[200],
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _name,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blueAccent[200],
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.blueAccent[200]),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent[200], width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent[200], width: 2)),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _mobilenumber,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.blueAccent[200]),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.blueAccent[200],
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent[200], width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent[200], width: 2)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _vehicle,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Vehicle Model',
                  labelStyle: TextStyle(color: Colors.blueAccent[200]),
                  prefixIcon: Icon(
                    Icons.directions_car,
                    color: Colors.blueAccent[200],
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent[200], width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Colors.blueAccent[200], width: 2)),
                ),
              ),
              SizedBox(height: 30),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.blueAccent[200],
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('register', true);
                    Navigator.popAndPushNamed(context,
                        '/main'); //Navigator.pushNamed(context, '/main');
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
