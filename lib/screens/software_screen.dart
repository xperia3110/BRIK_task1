import 'package:flutter/material.dart';

class SoftwareScreen extends StatefulWidget {
  const SoftwareScreen({Key? key}) : super(key: key);

  @override
  State<SoftwareScreen> createState() => _SoftwareScreenState();
}

class _SoftwareScreenState extends State<SoftwareScreen>
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
    // Each controller manages one type of animation with 900ms duration
    _topSectionController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this, // 'this' refers to the TickerProviderStateMixin
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

  // ANIMATION SEQUENCE METHOD
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
    final topSectionHeight = screenHeight * 1.0;
    final bottomSectionHeight = screenHeight * 0.75;
    
    return Scaffold(
      backgroundColor: const Color(0xFF7C3AED),
      
      body: Stack(
        children: [
          SlideTransition(
            position: _topSectionAnimation,
            child: Container(
              height: topSectionHeight,
              width: screenWidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF7C3AED), // Purple (primary tone)
                    Color(0xFF8B5CF6), // Lighter purple (secondary tone)
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
                  SlideTransition(
                    position: _elementsAnimation,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 110,
                          right: 40,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.code,
                              size: 50,
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
          

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _bottomSectionAnimation,
              child: Container(
                height: bottomSectionHeight,
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
                        'Microsoft',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED), 
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // COMPANY DESCRIPTION
                      const Text(
                        'Microsoft Corporation is an American multinational technology corporation founded in 1975. Headquartered in Redmond, Washington, Microsoft develops, manufactures, licenses, and sells computer software, consumer electronics, and personal computers. Best known for Windows operating systems, Office suite, Azure cloud platform, and Xbox gaming console.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF374151), // Dark gray 
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
          
          // MAIN HEADING 
          Positioned(
            top: bottomSectionHeight - 580, 
            left: 10,
            child: SlideTransition(
              position: _headingAnimation,
              child: const Text(
                'SOFTWARE',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.5,
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

