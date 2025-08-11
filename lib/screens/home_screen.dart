import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'defense_screen.dart';
import 'finance_screen.dart';
import 'manufacturing_screen.dart';
import 'software_screen.dart';
import 'healthcare_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            
            const SizedBox(height: 40),
            
            Expanded(
              child: _buildIndustryList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity, 
      color: Colors.white.withOpacity(0.9), // Semi-transparent white
      padding: const EdgeInsets.all(20.0), // 20px padding on all sides
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between title and icon
        children: [
          // App title
          Text(
            'DISCOVER BRANDS',
            style: TextStyle(
              fontSize: 24,                           // Text size
              fontWeight: FontWeight.bold,         
              color: AppColors.primaryText,           // Black color
              letterSpacing: 2.0,                     // Space between letters
            ),
          ),
          

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.searchIconBackground,  
              borderRadius: BorderRadius.circular(8),
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

 
  Widget _buildIndustryList(BuildContext context) {
    return ListView.builder(
      
      padding: const EdgeInsets.symmetric(horizontal: 40.0), // Left/right padding
      itemCount: industries.length, 
      
      itemBuilder: (context, index) {
 
        final industry = industries[index];
        
        return Padding(

          padding: const EdgeInsets.only(bottom: 30.0),
          child: _buildIndustryButton(context, industry),
        );
      },
    );
  }

  Widget _buildIndustryButton(BuildContext context, Industry industry) {
    return Container(
      width: double.infinity,     
      height: 80,              
      
      decoration: BoxDecoration(
        color: industry.backgroundColor,       
        borderRadius: BorderRadius.circular(40), 
        
       
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), 
            blurRadius: 8,                        
            offset: const Offset(0, 4),            
          ),
        ],
      ),
      

      child: Material(
        color: Colors.transparent,
        child: InkWell(
        
          borderRadius: BorderRadius.circular(40),
          
          onTap: () {
            _navigateToIndustry(context, industry);
          },
          
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
        return; 
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
