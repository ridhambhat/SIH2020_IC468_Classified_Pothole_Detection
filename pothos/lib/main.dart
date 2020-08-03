import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Register.dart';
import 'mainScreen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();  
  String bootstrap = prefs.getBool('register')==true? '/main':'/register';

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Pothos',
    initialRoute: bootstrap,
    routes: {
      '/main': (context) => MainScreen(),
      '/register': (context) => RegisterCar(),
    },
  ));
}