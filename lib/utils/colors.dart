import 'package:flutter/material.dart';

// This file contains all the colors used in our app

class AppColors {
  AppColors._();
  
  static const Color backgroundColor = Color(0xFF6B7A99); // Blue-gray background
  
  // Text colors
  static const Color primaryText = Color(0xFF000000);     // Black text
  static const Color secondaryText = Color(0xFF333333);   // Dark gray text
  
  static const Color defenseColor = Color(0xFFA8C686);      // Light green
  static const Color financeColor = Color(0xFFB8D4E3);      // Light blue  
  static const Color manufacturingColor = Color(0xFFD4C4A8); // Light brown/beige
  static const Color softwareColor = Color(0xFFC4B5DD);     // Light purple
  static const Color healthcareColor = Color(0xFFA8C686);   // Light green (same as defense)
  
  static const Color white = Color(0xFFFFFFFF);
  static const Color searchIconBackground = Color(0xFF000000); // Black background for search icon
}

class Industry {
  final String name;           
  final Color backgroundColor; 
  final String route;          
  

  const Industry({
    required this.name,
    required this.backgroundColor, 
    required this.route,
  });
}

const List<Industry> industries = [
  Industry(
    name: 'DEFENSE',
    backgroundColor: AppColors.defenseColor,
    route: '/defense',
  ),
  Industry(
    name: 'FINANCE', 
    backgroundColor: AppColors.financeColor,
    route: '/finance',
  ),
  Industry(
    name: 'MANUFACTURING',
    backgroundColor: AppColors.manufacturingColor,
    route: '/manufacturing',
  ),
  Industry(
    name: 'SOFTWARE',
    backgroundColor: AppColors.softwareColor,
    route: '/software',
  ),
  Industry(
    name: 'HEALTHCARE',
    backgroundColor: AppColors.healthcareColor,
    route: '/healthcare',
  ),
];
