import 'package:flutter/material.dart';
import '../page/profile_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF0D1B2A), // Lebih gelap, cocok untuk malam
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
                        const Icon(Icons.notifications, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            'Selamat Datang 🌙',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Tidurlah malam ini untuk hari esok yang lebih baik.',
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
                    children: const [
                      FeatureButton(icon: Icons.bar_chart, label: 'Statistik'),
                      FeatureButton(icon: Icons.menu_book, label: 'Edukasi'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SleepButton(text: 'Berita terkini tentang tidur'),
                  const SizedBox(height: 15),
                  SleepButton(text: 'Tips dan Artikel Sehat'),
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
            // Navigasi ke halaman profil
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics), label: 'Prediksi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Saya'),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeatureButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class SleepButton extends StatelessWidget {
  final String text;

  const SleepButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
