import 'package:flutter/material.dart';
import 'package:national_citizen/Screens/startScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'National Citizen',
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: const StartScreen() ,
    );
  }
}


