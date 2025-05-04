import 'package:flutter/material.dart';

void main() {
  runApp(const IsomnicApp());
}

class IsomnicApp extends StatelessWidget {
  const IsomnicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0C1446), Color(0xFF1D2A64)],
              ),
            ),
          ),

          // Bintang
          

          // Awan-awan
          Positioned(top: 60, left: 30, child: Image.asset('assets/images/images/claud_2.png', width: 100)),
          Positioned(top: 80, right: 30, child: Image.asset('assets/images/images/claud_3.png', width: 120)),
          Positioned(top: 150, left: 60, child: Image.asset('assets/images/images/claud_4.png', width: 90)),
          Positioned(top: 160, right: 30, child: Image.asset('assets/images/images/claud_4.png', width: 100)),

          // Judul
          Align(
            alignment: Alignment(0, -0.2),
            child: Text(
              "ISOMNIC",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),

          // Bulan & kucing
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 420,
                    child: Transform.scale(
                      scale: 1.5, // 1.0 = normal, > 1.0 = lebih besar
                      child: Image.asset(
                        'assets/images/images/bulan.png',
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),      
                Positioned(
                  bottom: 220,
                  child: Image.asset('assets/images/images/sleep_cat.png', width: 200),
                ),
              ],
            ),
          ),

          // Tombol Selanjutnya
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1D2A64),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // TODO: Navigasi ke halaman berikutnya
                },
                child: const Text(
                  'Selanjutnya',
                  style: TextStyle(fontSize: 16,color: Colors.white,),
                 
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
