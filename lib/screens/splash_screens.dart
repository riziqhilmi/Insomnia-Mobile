import 'package:flutter/material.dart';
import '../widgets/cloud_widget.dart';

import 'home_screens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1B41), // Deep navy blue for the night sky
              Color(0xFF141536), // Slightly darker blue at the bottom
            ],
          ),
        ),
        child: Stack(
          children: [
            // Stars (scattered across the screen)
            
            
            // Clouds (in various positions)
            const Positioned(
              left: 20,
              top: 80,
              child: CloudWidget(width: 80),
            ),
            const Positioned(
              right: 30,
              top: 60,
              child: CloudWidget(width: 70),
            ),
            const Positioned(
              right: 80,
              top: 200,
              child: CloudWidget(width: 100),
            ),
            const Positioned(
              left: 60,
              top: 180,
              child: CloudWidget(width: 120),
            ),
            const Positioned(
              right: 120,
              top: 140,
              child: CloudWidget(width: 90),
            ),
            
            // Main content column
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 120),
                // App Title
                const Text(
                  'ISOMNIC',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const Spacer(),
                
                // Moon with sleeping cat
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Moon
                    Container(
                      width: 280,
                      height: 280,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40FFFFFF),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: CustomPaint(
                        painter: MoonCratersPainter(),
                      ),
                    ),
                    // Sleeping cat positioned on top of the moon
                    Positioned(
                      top: 60,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/sleep_cat.png', 
                            width: 120,
                            height: 100,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 120,
                                height: 100,
                                color: Colors.orange[300],
                                child: Center(
                                  child: Icon(Icons.pets, color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Next button
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1B41),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Selanjutnya',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for moon craters
class MoonCratersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw several circles to represent craters
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.3), size.width * 0.08, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.4), size.width * 0.05, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.6), size.width * 0.07, paint);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.7), size.width * 0.04, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.7), size.width * 0.06, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}