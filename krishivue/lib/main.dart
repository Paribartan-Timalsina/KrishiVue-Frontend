import 'package:flutter/material.dart';
import 'package:krishivue/pages/intro.dart';
import 'package:krishivue/pages/landing.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      "/":(context)=>SplashScreen(),
      '/landing':(context)=>Landing(),
      
      

    },
  ));
}

