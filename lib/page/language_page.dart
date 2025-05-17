import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const LanguageSelectionApp());
}

class LanguageSelectionApp extends StatelessWidget {
  const LanguageSelectionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Selection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.transparent,
        brightness: Brightness.dark,
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
  String selectedLanguage = 'en';
  late AnimationController _controller;
  List<StarModel> stars = [];
  List<ZModel> zIcons = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Create stars
    for (int i = 0; i < 100; i++) {
      stars.add(StarModel(
        left: Random().nextDouble() * 1.0,
        top: Random().nextDouble() * 1.0,
        size: Random().nextDouble() * 2.0 + 1.0,
        delay: Random().nextDouble() * 5.0,
      ));
    }

    // Create Z icons for animation
    zIcons = [
      ZModel(bottom: 180, right: 40, size: 22, delay: 0),
      ZModel(bottom: 210, right: 70, size: 30, delay: 1),
      ZModel(bottom: 250, right: 110, size: 38, delay: 2),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2C3E50), Color(0xFF1A1F35)],
          ),
        ),
        child: Stack(
          children: [
            // Stars background
            ...stars.map((star) => _buildStar(star)).toList(),

            // Moon
            Positioned(
              top: 50,
              right: 50,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF4F6F8).withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      left: 15,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD2DCE6).withOpacity(0.4),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 25,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD2DCE6).withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Clouds
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: 30,
                  left: 40 + (_controller.value * MediaQuery.of(context).size.width),
                  child: Opacity(
                    opacity: 0.05,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                );
              },
            ),
            
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  bottom: 60,
                  right: 50 + (_controller.value * MediaQuery.of(context).size.width * -1),
                  child: Opacity(
                    opacity: 0.05,
                    child: Container(
                      width: 70,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                );
              },
            ),

            // Z icons
            ...zIcons.map((z) => _buildZIcon(z)).toList(),

            // Back button - ADDED HERE
            Positioned(
              top: 40,
              left: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF161C2D).withOpacity(0.6),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () {
                    // Handle back button press
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Back button pressed'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Main content container
            Center(
              child: Container(
                width: 320,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF161C2D).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Text(
                      'Choose Your Language',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select your preferred language to continue',
                      style: TextStyle(
                        color: const Color(0xFFA0AEC0),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    
                    // Language buttons
                    _buildLanguageButton(
                      flagText: 'EN',
                      languageName: 'English',
                      languageNative: 'English',
                      value: 'en',
                      flagColor: Colors.blue.shade800,
                    ),
                    const SizedBox(height: 12),
                    _buildLanguageButton(
                      flagText: 'ID',
                      languageName: 'Indonesian',
                      languageNative: 'Bahasa Indonesia',
                      value: 'id',
                      flagColor: Colors.red.shade800,
                    ),
                    
                    const SizedBox(height: 25),
                    
                    // Continue button
                    ElevatedButton(
                      onPressed: () {
                        // Handle language confirmation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Selected language: $selectedLanguage'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4568DC), Color(0xFF5F78DC)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: const Text(
                            'Continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required String flagText,
    required String languageName,
    required String languageNative,
    required String value,
    required Color flagColor,
  }) {
    final bool isSelected = selectedLanguage == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          selectedLanguage = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
            ? const Color(0xFF4E65A8).withOpacity(0.7)
            : const Color(0xFF2D375A).withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF7896FF).withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Flag represented as a colored circle with text
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: flagColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: flagColor.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                flagText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 15),
            
            // Language info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    languageNative,
                    style: TextStyle(
                      color: const Color(0xFFA0AEC0),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // Selected indicator
            if (isSelected) 
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStar(StarModel star) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 5),
      builder: (context, value, child) {
        return Positioned(
          left: star.left * MediaQuery.of(context).size.width,
          top: star.top * MediaQuery.of(context).size.height,
          child: Opacity(
            opacity: (sin(value * pi * 2 + star.delay) + 1) / 2, // Twinkle effect
            child: Container(
              width: star.size,
              height: star.size,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildZIcon(ZModel z) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 10),
      builder: (context, value, child) {
        // Create a float-up animation
        final position = value < 0.5 
            ? Curves.easeInOut.transform(value * 2) * 100 
            : 100;
        final opacity = value < 0.2 
            ? Curves.easeIn.transform(value * 5) 
            : (value > 0.8 ? Curves.easeOut.transform((1 - value) * 5) : 1.0);
            
        return Positioned(
          bottom: z.bottom.toDouble() + position,
          right: z.right.toDouble(),
          child: Opacity(
            opacity: opacity * 0.7,
            child: Text(
              'z',
              style: TextStyle(
                color: Colors.white,
                fontSize: z.size.toDouble(),
                fontWeight: FontWeight.bold,
                fontFamily: 'cursive',
              ),
            ),
          ),
        );
      },
    );
  }
}

class StarModel {
  final double left;
  final double top;
  final double size;
  final double delay;

  StarModel({
    required this.left,
    required this.top,
    required this.size,
    required this.delay,
  });
}

class ZModel {
  final int bottom;
  final int right;
  final int size;
  final int delay;

  ZModel({
    required this.bottom,
    required this.right,
    required this.size,
    required this.delay,
  });
}