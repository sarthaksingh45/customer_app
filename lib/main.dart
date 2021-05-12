import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/homescreen.dart';
import './screens/auth_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import './models/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        accentColorBrightness: Brightness.dark,
        primarySwatch: generateMaterialColor(Colors.amber),
        //primaryColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.red[800],
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, snapShot) {
          if (snapShot.hasData) {
            return HomeScreen();
          } else {
            return AuthScreen();
          }
        },
      ),
    );
  }
}
