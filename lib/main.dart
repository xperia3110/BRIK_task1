import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; 

void main() {
  runApp(const BrandDiscoveryApp());
}

class BrandDiscoveryApp extends StatelessWidget {
  const BrandDiscoveryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brand Discovery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary color scheme
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
        // Font family for the entire app
        fontFamily: 'Roboto',
        
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      
      home: const HomeScreen(),
    );
  }
}
