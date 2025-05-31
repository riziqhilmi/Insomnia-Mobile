import 'package:flutter/material.dart';
import '../page/profile_page.dart';
import 'education_page.dart';
import 'prediski_page.dart';
import 'tips_page.dart';
import 'package:get/get.dart';
import '../page/statistik_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Stack(
        children: [
          // Bagian atas
          Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/images/logo1.png',
                          height: 40,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Insomic",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Serif',
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'selamat Datang 🌙'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'tidurlah malam ini untuk hari esok yang lebih baik.'.tr,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/images/images/people.png',
                        height: 180,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bagian bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              height: 340,
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FeatureButton(
                        icon: Icons.bar_chart,
                        label: 'statistik'.tr,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StatistikPage(),
                            ),
                          );
                        },
                      ),
                      FeatureButton(
                        icon: Icons.menu_book,
                        label: 'edukasi'.tr,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EducationPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SleepButton(
                    text: 'berita terkini tentang tidur'.tr,
                    onPressed: () {
                      // Arahkan ke halaman berita jika sudah tersedia
                      Get.snackbar(
                        'info'.tr,
                        'fitur berita masih dalam pengembangan.'.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.deepPurple,
                        colorText: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  SleepButton(
                    text: 'tips tidur sehat'.tr,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TipsTidurPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF1B263B),
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SleepClassificationPage()),
            );
          }
        },
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'beranda'.tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: 'prediksi'.tr),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'saya'.tr),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const FeatureButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.deepPurple[700],
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class SleepButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SleepButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple[600],
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
