import 'package:flutter/material.dart';

class SplashBackground extends StatelessWidget {
  const SplashBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0C1446), Color(0xFF1D2A64)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 60,
              left: 30,
              child: Image.asset('assets/images/images/claud_2.png', width: 100)),
          Positioned(
              top: 80,
              right: 30,
              child: Image.asset('assets/images/images/claud_3.png', width: 120)),
          Positioned(
              top: 150,
              left: 60,
              child: Image.asset('assets/images/images/claud_4.png', width: 90)),
          Positioned(
              top: 160,
              right: 30,
              child: Image.asset('assets/images/images/claud_4.png', width: 100)),
        ],
      ),
    );
  }
}

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
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
    );
  }
}

class SplashCatAndMoon extends StatelessWidget {
  const SplashCatAndMoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 600,
            child: Transform.scale(
              scale: 1.5,
              child: Image.asset(
                'assets/images/images/bulan.png',
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          const Positioned(
            bottom: 300,
            child: Image(
              image: AssetImage('assets/images/images/sleep_cat.png'),
              width: 250,
            ),
          ),
        ],
      ),
    );
  }
}
