import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("kata sandi wajib diisi")),
      );
      return;
    }
    // TODO: Tambahkan logika untuk mengirim permintaan reset password ke server
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Permintaan reset password dikirim")),
    );
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
          // Efek bintang berkelap-kelip
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  // Header
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
                              color: Colors.black26,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Judul Reset Password
                  Text(
                    "Reset Password",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black26,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Masukkan sandi dan kata sandi baru Anda",
                    style: GoogleFonts.lato(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Form input
                  CustomTextField(
                    controller: passwordController,
                    icon: Icons.lock_open,
                    hintText: "Kata Sandi ",
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: passwordController,
                    icon: Icons.lock,
                    hintText: "Kata Sandi Baru",
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  // Tombol Reset
                  AnimatedOpacityButton(
                    child: CustomButton(
                      text: "Reset Password",
                      onPressed: _handleResetPassword,
                    ),
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

// Widget untuk tombol dengan animasi opacity
class AnimatedOpacityButton extends StatefulWidget {
  final Widget child;

  const AnimatedOpacityButton({super.key, required this.child});

  @override
  _AnimatedOpacityButtonState createState() => _AnimatedOpacityButtonState();
}

class _AnimatedOpacityButtonState extends State<AnimatedOpacityButton> {
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
      },
      onTapCancel: () {
        setState(() {
          _opacity = 1.0;
        });
      },
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 200),
        child: widget.child,
      ),
    );
  }
}

// CustomPainter untuk bintang
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