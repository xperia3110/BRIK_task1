import 'package:flutter/material.dart';

class ManufacturingScreen extends StatefulWidget {
  const ManufacturingScreen({Key? key}) : super(key: key);

  @override
  State<ManufacturingScreen> createState() => _ManufacturingScreenState();
}

class _ManufacturingScreenState extends State<ManufacturingScreen>
    with TickerProviderStateMixin {
  
  // ANIMATION CONTROLLERS
  late AnimationController _topSectionController;
  late AnimationController _bottomSectionController;
  late AnimationController _headingController;
  late AnimationController _elementsController;

  // ANIMATION OBJECTS
  late Animation<Offset> _topSectionAnimation;
  late Animation<Offset> _bottomSectionAnimation;
  late Animation<Offset> _headingAnimation;
  late Animation<Offset> _elementsAnimation;

  @override
  void initState() {
    super.initState();

    // INITIALIZE ALL ANIMATION CONTROLLERS
    _topSectionController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _bottomSectionController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _headingController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _elementsController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    // DEFINE SLIDE ANIMATIONS WITH TWEEN
    _topSectionAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _topSectionController,
      curve: Curves.easeInOut,
    ));

    _bottomSectionAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _bottomSectionController,
      curve: Curves.easeInOut,
    ));

    _headingAnimation = Tween<Offset>(
      begin: const Offset(-1.1, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headingController,
      curve: Curves.easeInOut,
    ));

    _elementsAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _elementsController,
      curve: Curves.easeInOut,
    ));

    // START THE ANIMATION SEQUENCE
    _startAnimations();
  }

  // ANIMATION SEQUENCE METHOD - FIXED TIMING
  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 10));
    _topSectionController.forward();
    
    await Future.delayed(const Duration(milliseconds: 50));  
    _bottomSectionController.forward();
    
    await Future.delayed(const Duration(milliseconds: 50));
    _headingController.forward();
    
    await Future.delayed(const Duration(milliseconds: 50));
    _elementsController.forward();
  }

  @override
  void dispose() {
    _topSectionController.dispose();
    _bottomSectionController.dispose();
    _headingController.dispose();
    _elementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // FIXED DIMENSIONS - Same as software screen
    final topSectionHeight = screenHeight * 1.0;    // Full screen height
    final bottomSectionHeight = screenHeight * 0.75; // 75% of screen
    
    return Scaffold(
      backgroundColor: const Color(0xFFB45309), // Orange background
      
      body: Stack(
        children: [
          // TOP SECTION WITH GRADIENT
          SlideTransition(
            position: _topSectionAnimation,
            child: Container(
              height: topSectionHeight, // FIXED: Full screen height
              width: screenWidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB45309), // Orange-brown (primary tone)
                    Color(0xFFD97706), // Lighter orange (secondary tone)
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // BACK BUTTON
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  
                  // MANUFACTURING VISUAL ELEMENTS - REMOVED CUSTOM PAINT
                  SlideTransition(
                    position: _elementsAnimation,
                    child: Stack(
                      children: [
                        // GEAR ICON - positioned in top-right
                        Positioned(
                          top: 110,
                          right: 28,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.settings,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // BOTTOM SECTION WITH CONTENT
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _bottomSectionAnimation,
              child: Container(
                height: bottomSectionHeight, // FIXED: 75% of screen
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      
                      // COMPANY NAME
                      const Text(
                        'General Electric',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB45309),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // COMPANY DESCRIPTION
                      const Text(
                        'General Electric is an American multinational conglomerate founded in 1892. The company operates through multiple segments including Aviation, Healthcare, Power, and Renewable Energy. GE has been a pioneer in industrial manufacturing, producing jet engines, power turbines, medical imaging equipment, and renewable energy solutions that power the world.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF374151),
                          height: 1.6,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // MAIN HEADING - FIXED POSITIONING
          Positioned(
            top: bottomSectionHeight - 580, // FIXED: Same calculation as software
            left: 10,
            child: SlideTransition(
              position: _headingAnimation,
              child: const Text(
                'MANUFACTURING',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}