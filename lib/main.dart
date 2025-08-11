import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import our home screen

// This is the entry point of our Flutter app
// void main() is the first function that runs when the app starts
void main() {
  // runApp() takes a widget and makes it the root of the widget tree
  runApp(const BrandDiscoveryApp());
}

// BrandDiscoveryApp is our main app widget
// It extends StatelessWidget because the app configuration doesn't change
class BrandDiscoveryApp extends StatelessWidget {
  const BrandDiscoveryApp({Key? key}) : super(key: key);

  // build() method defines what our app looks like
  @override
  Widget build(BuildContext context) {
    // MaterialApp provides Material Design styling and navigation
    // It's like the shell that contains all our screens
    return MaterialApp(
      // App title (shown in task switcher on some devices)
      title: 'Brand Discovery',
      
      // Remove the debug banner in top-right corner
      debugShowCheckedModeBanner: false,
      
      // App theme configuration
      theme: ThemeData(
        // Primary color scheme
        primarySwatch: Colors.blue,
        
        // This ensures text scales properly across devices
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
        // Font family for the entire app
        fontFamily: 'Roboto',
        
        // Configure page transitions for smoother animations
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      
      // The first screen users see when app opens
      home: const HomeScreen(),
    );
  }
}