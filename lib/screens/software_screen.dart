import 'package:flutter/material.dart';

class SoftwareScreen extends StatefulWidget {
  const SoftwareScreen({Key? key}) : super(key: key);

  @override
  State<SoftwareScreen> createState() => _SoftwareScreenState();
}

class _SoftwareScreenState extends State<SoftwareScreen>
    with TickerProviderStateMixin {
  
  // ANIMATION CONTROLLERS
  // These control the timing and state of each animation
  // TickerProviderStateMixin provides the ticker for smooth animations
  late AnimationController _topSectionController;    // Controls top gradient animation
  late AnimationController _bottomSectionController; // Controls bottom white section animation
  late AnimationController _headingController;       // Controls heading text animation
  late AnimationController _elementsController;      // Controls visual elements animation

  // ANIMATION OBJECTS
  // These define how elements move (slide directions and curves)
  late Animation<Offset> _topSectionAnimation;    // Top section slides down from above
  late Animation<Offset> _bottomSectionAnimation; // Bottom section slides up from below
  late Animation<Offset> _headingAnimation;       // Heading slides in from left
  late Animation<Offset> _elementsAnimation;      // Elements slide in from right

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
    // Tween defines start and end positions for animations
    _topSectionAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Start from top (above screen)
      end: Offset.zero,                // End at normal position
    ).animate(CurvedAnimation(
      parent: _topSectionController,
      curve: Curves.easeInOut,         // Smooth acceleration/deceleration
    ));

    _bottomSectionAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),  // Start from bottom (below screen)
      end: Offset.zero,                // End at normal position
    ).animate(CurvedAnimation(
      parent: _bottomSectionController,
      curve: Curves.easeInOut,
    ));

    _headingAnimation = Tween<Offset>(
      begin: const Offset(-1.1, 0.0), // Start from left (off screen)
      end: Offset.zero,                // End at normal position
    ).animate(CurvedAnimation(
      parent: _headingController,
      curve: Curves.easeInOut,
    ));

    _elementsAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),  // Start from right (off screen)
      end: Offset.zero,                // End at normal position
    ).animate(CurvedAnimation(
      parent: _elementsController,
      curve: Curves.easeInOut,
    ));

    // START THE ANIMATION SEQUENCE
    _startAnimations();
  }

  // ANIMATION SEQUENCE METHOD
  // This controls the timing and order of all animations
  void _startAnimations() async {
    // PHASE 1: Background sections animate first (top and bottom)
    // This creates the dual-tone background before content appears
    
    // Start top section animation immediately
    await Future.delayed(const Duration(milliseconds: 10));
    _topSectionController.forward(); // Purple gradient slides down from top
    
    // Start bottom section animation shortly after top
    await Future.delayed(const Duration(milliseconds: 50));  
    _bottomSectionController.forward(); // White section slides up from bottom
    
    // PHASE 2: Content animations start after background is set
    // Wait for background to be mostly in place before showing content
    
    // Start heading animation (slides from left)
    await Future.delayed(const Duration(milliseconds: 50)); // Longer delay for background to settle
    _headingController.forward(); // "SOFTWARE" text slides in from left
    
    // Start visual elements animation (slides from right)
    await Future.delayed(const Duration(milliseconds: 50)); // Small delay after heading
    _elementsController.forward(); // Code icon and binary slide in from right
  }

  @override
  void dispose() {
    // CLEANUP: Dispose all controllers to prevent memory leaks
    // This is called when the widget is removed from the widget tree
    _topSectionController.dispose();
    _bottomSectionController.dispose();
    _headingController.dispose();
    _elementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height to calculate proper proportions
    // This helps us avoid overflow issues by using exact measurements
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate heights for different sections
    // Top section: 55% of screen (reduced from 60% to fix heading overlap)
    final topSectionHeight = screenHeight * 1.0;
    // Bottom section: 50% of screen (overlaps with top for dual-tone effect)
    final bottomSectionHeight = screenHeight * 0.75;
    
    return Scaffold(
      // Set background color to prevent any white flashes during animation
      backgroundColor: const Color(0xFF7C3AED),
      
      body: Stack(
        children: [
          // TOP SECTION WITH GRADIENT
          // This contains the purple gradient background and visual elements
          SlideTransition(
            position: _topSectionAnimation,
            child: Container(
              // Use calculated height to prevent overflow
              height: topSectionHeight,
              width: screenWidth, // Take full width
              decoration: const BoxDecoration(
                // Dual-tone gradient as requested
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
                  // Positioned in top-left corner for easy access
                  Positioned(
                    top: 50, // Safe area padding
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
                  
                  // SOFTWARE VISUAL ELEMENTS (code icon and binary)
                  // These slide in from the right side
                  SlideTransition(
                    position: _elementsAnimation,
                    child: Stack(
                      children: [
                        // CODE ICON - positioned in top-right
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
          
          // BOTTOM SECTION WITH CONTENT
          // This contains the white background and company information
          Positioned(
            // Position it to create overlap with top section for dual-tone effect
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _bottomSectionAnimation,
              child: Container(
                // Use calculated height to prevent overflow
                height: bottomSectionHeight,
                decoration: const BoxDecoration(
                  // White background for contrast with purple top
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  // Wrap content in scrollable widget to prevent overflow
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add space at top to prevent text cutoff
                      const SizedBox(height: 40),
                      
                      // COMPANY NAME
                      const Text(
                        'Microsoft',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED), // Match top section color
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // COMPANY DESCRIPTION
                      const Text(
                        'Microsoft Corporation is an American multinational technology corporation founded in 1975. Headquartered in Redmond, Washington, Microsoft develops, manufactures, licenses, and sells computer software, consumer electronics, and personal computers. Best known for Windows operating systems, Office suite, Azure cloud platform, and Xbox gaming console.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF374151), // Dark gray for readability
                          height: 1.6, // Line height for better readability
                          letterSpacing: 0.5,
                        ),
                      ),
                      // Add bottom padding for scrolling comfort
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // MAIN HEADING - POSITIONED BETWEEN TOP AND BOTTOM SECTIONS
          // This appears in the overlap area for perfect positioning
          Positioned(
            // Position it in the overlap zone between top and bottom sections
            top: bottomSectionHeight - 580, // 60px above the bottom section starts
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
                  // Add shadow for better visibility over dual-tone background
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

