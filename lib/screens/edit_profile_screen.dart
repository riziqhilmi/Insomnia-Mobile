import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with SingleTickerProviderStateMixin {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
  final TextEditingController profesiController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  late AnimationController _starAnimationController;
  late Animation<double> _starAnimation;

  @override
  void initState() {
    super.initState();
    _starAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _starAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _starAnimationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    umurController.dispose();
    profesiController.dispose();
    alamatController.dispose();
    _starAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Latar belakang gradient
          Container(
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
          // Efek bintang berkelap-kelip menggunakan CustomPainter
          CustomPaint(
            painter: StarryBackgroundPainter(),
            child: Container(),
          ),
          // Overlay gelap
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Header dengan tombol kembali
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Tombol Kembali dengan soft glow dan floating stars
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Floating stars animation
                          AnimatedBuilder(
                            animation: _starAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: FloatingStarsPainter(_starAnimation.value),
                                child: const SizedBox(
                                  width: 40,
                                  height: 40,
                                ),
                              );
                            },
                          ),
                          // Tombol kembali dengan soft glow
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF88B7B5).withOpacity(0.4),
                                  blurRadius: 12,
                                  spreadRadius: 2,
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
                                Navigator.pop(context); // Kembali ke ProfilePage
                              },
                            ),
                          ),
                        ],
                      ),
                      // Ikon dan teks Insomnic
                      Row(
                        children: [
                          AnimatedScaleIcon(),
                          const SizedBox(width: 8),
                          Text(
                            "Insomnic",
                            style: GoogleFonts.pacifico(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
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
                      // Spacer untuk keseimbangan
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Avatar dengan border gradient
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6B4E71), Color(0xFF88B7B5)],
                          ),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 60, color: Colors.grey[700]),
                        ),
                      ),
                      AnimatedEditButton(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Edit Profil",
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.white,
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
                  const SizedBox(height: 24),
                  // Form input menggunakan CustomTextField
                  CustomTextField(
                    controller: namaController,
                    icon: Icons.person,
                    hintText: "Nama Lengkap",
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: umurController,
                    icon: Icons.cake,
                    hintText: "Umur",
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: profesiController,
                    icon: Icons.school,
                    hintText: "Profesi / Sekolah",
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: alamatController,
                    icon: Icons.home,
                    hintText: "Alamat Lengkap",
                    obscureText: false,
                  ),
                  const SizedBox(height: 24),
                  // Tombol Simpan
                  CustomButton(
                    text: "Simpan Profil",
                    onPressed: () {
                      // TODO: Tambahkan fungsi simpan
                      if (namaController.text.isEmpty || umurController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Nama dan Umur wajib diisi")),
                        );
                        return;
                      }
                      // Contoh: Simpan data
                      print("Data disimpan: ${namaController.text}, ${umurController.text}");
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
}

// Widget untuk animasi ikon
class AnimatedScaleIcon extends StatefulWidget {
  @override
  _AnimatedScaleIconState createState() => _AnimatedScaleIconState();
}

class _AnimatedScaleIconState extends State<AnimatedScaleIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: const Icon(Icons.nightlight, color: Colors.white, size: 30),
    );
  }
}

// Widget untuk tombol edit dengan animasi
class AnimatedEditButton extends StatefulWidget {
  @override
  _AnimatedEditButtonState createState() => _AnimatedEditButtonState();
}

class _AnimatedEditButtonState extends State<AnimatedEditButton> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _opacity = 0.7;
        });
      },
      onTapUp: (_) {
        setState(() {
          _opacity = 1.0;
        });
        // TODO: Tambahkan fungsi edit avatar
      },
      onTapCancel: () {
        setState(() {
          _opacity = 1.0;
        });
      },
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 200),
        child: CircleAvatar(
          radius: 18,
          backgroundColor: const Color(0xFF6B4E71),
          child: const Icon(Icons.edit, size: 16, color: Colors.white),
        ),
      ),
    );
  }
}

// CustomPainter untuk bintang berkelap-kelip di latar belakang
class StarryBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.1), 2, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.3), 1.5, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.6), 1, paint);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.8), 1.2, paint);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.2), 1.8, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// CustomPainter untuk floating stars di sekitar tombol kembali
class FloatingStarsPainter extends CustomPainter {
  final double animationValue;

  FloatingStarsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Posisi dan opacity bintang berubah berdasarkan animasi
    for (int i = 0; i < 5; i++) {
      final double angle = (2 * 3.14159 * i / 5) + (animationValue * 2 * 3.14159);
      final double radius = 10 + (i % 2 == 0 ? 5 : 0);
      final double starX = size.width / 2 + radius * (i + 1) / 2 * 0.5 * (animationValue * 2 - 1);
      final double starY = size.height / 2 + radius * (i + 1) / 2 * (animationValue * 2 - 1);
      final double opacity = (0.5 + 0.5 * (animationValue * 2 - 1)).clamp(0.0, 1.0);

      paint.color = Colors.white.withOpacity(opacity);
      canvas.drawCircle(Offset(starX, starY), 1.5 - (i % 2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant FloatingStarsPainter oldDelegate) => true;
}