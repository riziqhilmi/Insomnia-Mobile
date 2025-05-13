import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:google_fonts/google_fonts.dart';

class SecurityPrivacyScreen extends StatefulWidget {
  final String username;
  final String phone;
  final String email;

  const SecurityPrivacyScreen({
    super.key,
    required this.username,
    required this.phone,
    required this.email,
  });

  @override
  State<SecurityPrivacyScreen> createState() => _SecurityPrivacyScreenState();
}

class _SecurityPrivacyScreenState extends State<SecurityPrivacyScreen>
    with TickerProviderStateMixin {
  late AnimationController _starAnimationController;

  @override
  void initState() {
    super.initState();
    _starAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _starAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Latar belakang dengan animasi bintang
          AnimatedBackground(
            vsync: this,
            behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                baseColor: Colors.white.withOpacity(0.3),
                spawnOpacity: 0.0,
                opacityChangeRate: 0.25,
                minOpacity: 0.1,
                maxOpacity: 0.4,
                particleCount: 80,
                spawnMaxRadius: 3.0,
                spawnMinRadius: 1.0,
                spawnMaxSpeed: 20.0,
                spawnMinSpeed: 5.0,
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1C2526), // Biru gelap
                    Color(0xFF2E1A47), // Ungu muda
                  ],
                ),
              ),
            ),
          ),

          // Elemen dekoratif (Bulan dan Karakter Tidur)
          Positioned(
            top: 60,
            left: 20,
            child: Row(
              children: [
                const Icon(Icons.brightness_low, size: 40, color: Colors.white30),
                const SizedBox(width: 10),
                Text(
                  "Profil Saya",
                  style: GoogleFonts.lato(
                    color: Colors.white70,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 120,
            right: 20,
            child: CustomPaint(
              painter: MoonPainter(),
              child: const SizedBox(width: 60, height: 60),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 20,
            child: CustomPaint(
              painter: SleepingCharacterPainter(),
              child: const SizedBox(width: 100, height: 100),
            ),
          ),

          // Konten Profil
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150), // Jarak dari elemen dekoratif
                  _buildProfileItem(
                    icon: Icons.person_outline,
                    title: "Username",
                    value: widget.username,
                    onTap: () {
                      // Navigasi ke halaman edit username
                      print("Edit Username");
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildProfileItem(
                    icon: Icons.phone,
                    title: "No. Handphone",
                    value: widget.phone,
                    onTap: () {
                      // Navigasi ke halaman edit nomor handphone
                      print("Edit No. Handphone");
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildProfileItem(
                    icon: Icons.email_outlined,
                    title: "Email",
                    value: widget.email,
                    onTap: () {
                      // Navigasi ke halaman edit email
                      print("Edit Email");
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildProfileItem(
                    icon: Icons.lock_outline,
                    title: "Ganti Password",
                    value: "",
                    onTap: () {
                      // Navigasi ke halaman ganti password
                      print("Ganti Password");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.05),
              Colors.white.withOpacity(0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.white70, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: GoogleFonts.lato(
                color: Colors.white38,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 30, paint);
    final darkPaint = Paint()
      ..color = Colors.blueGrey.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2 + 10, size.height / 2 - 10), 20, darkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SleepingCharacterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    // Kepala karakter
    canvas.drawCircle(Offset(size.width / 2, size.height / 2 - 20), 20, paint);

    // Badan (sederhana)
    final bodyPaint = Paint()
      ..color = Colors.blue.withOpacity(0.7)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 10, size.height / 2, 20, 30),
      bodyPaint,
    );

    // Zzz (efek tidur)
    final zzzPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2 + 30, size.height / 2 - 40), 3, zzzPaint);
    canvas.drawCircle(Offset(size.width / 2 + 35, size.height / 2 - 35), 2, zzzPaint);
    canvas.drawCircle(Offset(size.width / 2 + 40, size.height / 2 - 30), 1, zzzPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}