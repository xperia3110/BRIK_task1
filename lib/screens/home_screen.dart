import 'package:flutter/material.dart';
import '../utils/colors.dart'; // Import our color constants
import 'defense_screen.dart';
import 'finance_screen.dart';
import 'manufacturing_screen.dart';
import 'software_screen.dart';
import 'healthcare_screen.dart';

// HomeScreen is a StatelessWidget because it doesn't change over time
// StatelessWidget = Static content that doesn't need to update
// StatefulWidget = Dynamic content that can change (we'll use this later)
class HomeScreen extends StatelessWidget {
  // Constructor - every widget needs this
  // Key is used by Flutter to identify widgets in the widget tree
  const HomeScreen({Key? key}) : super(key: key);

  // build() method - this is where we describe what the screen looks like
  // BuildContext contains information about where this widget sits in the widget tree
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic screen structure (app bar, body, etc.)
    return Scaffold(
      // Set the background color to match your design
      backgroundColor: AppColors.backgroundColor,
      
      // SafeArea ensures content doesn't go behind status bar/notch
      body: SafeArea(
        child: Column(
          // Column arranges children vertically (top to bottom)
          children: [
            // Header section with title and search icon
            _buildHeader(),
            
            // Add some space between header and content
            const SizedBox(height: 40),
            
            // Main content area with industry buttons
            Expanded(
              // Expanded makes this widget take up remaining space
              child: _buildIndustryList(context),
            ),
          ],
        ),
      ),
    );
  }

  // Private method to build the header section
  // The underscore (_) makes this method private - only this class can use it
  Widget _buildHeader() {
    return Container(
      // Container is like a box that can hold other widgets
      width: double.infinity, // Take full width
      color: Colors.white.withOpacity(0.9), // Semi-transparent white
      padding: const EdgeInsets.all(20.0), // 20px padding on all sides
      
      child: Row(
        // Row arranges children horizontally (left to right)
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between title and icon
        children: [
          // App title
          Text(
            'DISCOVER BRANDS',
            style: TextStyle(
              fontSize: 24,                           // Text size
              fontWeight: FontWeight.bold,            // Make it bold
              color: AppColors.primaryText,           // Black color
              letterSpacing: 2.0,                     // Space between letters
            ),
          ),
          
          // Search icon in black container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.searchIconBackground,   // Black background
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: Icon(
              Icons.search,           // Search icon
              color: Colors.white,    // White icon color
              size: 24,              // Icon size
            ),
          ),
        ],
      ),
    );
  }

  // Private method to build the list of industry buttons
  Widget _buildIndustryList(BuildContext context) {
    return ListView.builder(
      // ListView.builder creates a scrollable list
      // It only builds items that are visible (performance optimization)
      
      padding: const EdgeInsets.symmetric(horizontal: 40.0), // Left/right padding
      itemCount: industries.length, // How many items to show
      
      // This function is called for each item in the list
      itemBuilder: (context, index) {
        // Get the industry data for this position
        final industry = industries[index];
        
        return Padding(
          // Add space between buttons
          padding: const EdgeInsets.only(bottom: 30.0),
          child: _buildIndustryButton(context, industry),
        );
      },
    );
  }

  // Private method to build individual industry button
  Widget _buildIndustryButton(BuildContext context, Industry industry) {
    return Container(
      width: double.infinity,     // Full width
      height: 80,                 // Fixed height
      
      decoration: BoxDecoration(
        color: industry.backgroundColor,        // Button color from our data
        borderRadius: BorderRadius.circular(40), // Rounded pill shape
        
        // Add subtle shadow for depth
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Light shadow
            blurRadius: 8,                         // How soft the shadow is  
            offset: const Offset(0, 4),            // Shadow position (x, y)
          ),
        ],
      ),
      
      // Material widget enables tap effects
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // InkWell provides tap functionality and ripple effect
          borderRadius: BorderRadius.circular(40),
          
          // What happens when button is tapped
          onTap: () {
            _navigateToIndustry(context, industry);
          },
          
          // Button content
          child: Center(
            child: Text(
              industry.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryText,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to handle navigation when button is tapped
  void _navigateToIndustry(BuildContext context, Industry industry) {
    Widget destinationScreen;
    
    // Navigate to appropriate screen based on industry
    switch (industry.name) {
      case 'DEFENSE':
        destinationScreen = const DefenseScreen();
        break;
      case 'FINANCE':
        destinationScreen = const FinanceScreen();
        break;
      case 'MANUFACTURING':
        destinationScreen = const ManufacturingScreen();
        break;
      case 'SOFTWARE':
        destinationScreen = const SoftwareScreen();
        break;
      case 'HEALTHCARE':
        destinationScreen = const HealthcareScreen();
        break;
      default:
        return; // Do nothing if industry not found
    }

    // Navigate to the selected screen with smooth transition
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destinationScreen,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}