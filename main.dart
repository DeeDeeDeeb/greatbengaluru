import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(NammaYatriApp());
}

class NammaYatriApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: HomeScreen(),
    );
  }
}