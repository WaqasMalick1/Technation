import 'package:DemoApp/UI/Screens/DetailScreen.dart';
import 'package:DemoApp/UI/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}
//Colors for theme
   Color lightPrimary = Colors.white;
   Color darkPrimary = Colors.black;
   Color lightAccent = Colors.white;
   Color darkAccent = Colors.white;
   Color lightBG = Colors.white;
   Color darkBG = Colors.black;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme : ThemeData(
   textTheme: TextTheme(
     title: GoogleFonts.roboto(
          textStyle: TextStyle(
          
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        )
   ),
    brightness: Brightness.light,
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    primaryColorDark: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade200,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: GoogleFonts.roboto(
          textStyle: TextStyle(
          
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
        )
      ),
    ),
  ),
      home: HomeScreen(),
    );
  }
}

