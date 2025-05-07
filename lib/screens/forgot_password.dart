import 'package:flutter/material.dart';
import '../widgets/custom_button.dart'; 
import 'otp_verification_screen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;

  // Animation controller for error shake effect
  late AnimationController _errorAnimationController;
  late Animation<Offset> _errorAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller with this class as vsync
    _errorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    // Create a shake animation
    _errorAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _errorAnimationController,
      curve: Curves.elasticIn,
    ));

    _errorAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _errorAnimationController.reverse();
      }
    });
    
    // Listen for changes in the text field
    _emailController.addListener(_onEmailChanged);
  }

  void _onEmailChanged() {
    // If there was an error before, validate on change to provide immediate feedback
    if (_emailError != null) {
      _validateEmail(showError: false);
    }
  }

  @override
  void dispose() {
    _errorAnimationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _validateEmail({bool showError = true}) {
    final email = _emailController.text.trim();
    
    if (email.isEmpty) {
      if (showError) {
        setState(() {
          _emailError = 'Email tidak boleh kosong';
        });
      }
      return false;
    } else if (!email.contains('@')) {
      if (showError) {
        setState(() {
          _emailError = 'Email harus mengandung tanda "@"';
        });
      }
      return false;
    } else {
      setState(() {
        _emailError = null;
      });
      return true;
    }
  }

  void _handleSubmit() {
    if (_validateEmail()) {
      // Email is valid, proceed with reset
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permintaan reset password dikirim!'),
          backgroundColor: Color(0xFF4B6DE9),
        ),
      );
    } else {
      // Show error animation
      _errorAnimationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
              iconSize: 20,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F1A30), Color(0xFF1E2E4A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  buildMoonWidget(size),
                  const SizedBox(height: 40),
                  const Text(
                    'Lupa Password',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Masukkan email Anda untuk reset password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  
                  // Email field with error message
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedBuilder(
                        animation: _errorAnimationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: _errorAnimation.value,
                            child: child,
                          );
                        },
                        child: _buildCustomTextField(),
                      ),
                      if (_emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12, top: 8),
                          child: Text(
                            _emailError!,
                            style: const TextStyle(
                              color: Color(0xFFFF8A8A),
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                             CustomButton(
  text: 'Kirim',
  onPressed: () {
    if (_validateEmail()) {
      // Jika email valid, navigasi ke OtpVerificationScreen dengan email
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(email: _emailController.text),
        ),
      );
    } else {
      // Tampilkan animasi kesalahan jika email tidak valid
      _errorAnimationController.forward(from: 0.0);
    }
  },
  gradient: const LinearGradient(
    colors: [Color(0xFF6E8EF7), Color(0xFF4B6DE9)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ),
),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Custom method to build the TextField with a controller
  Widget _buildCustomTextField() {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white12,
            prefixIcon: const Icon(Icons.email_outlined, color: Colors.white),
            hintText: 'Email',
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          ),
          onChanged: (value) {
            // Optional: you can add specific validation logic here if needed
          },
        ),
      ),
    );
  }

  Widget buildMoonWidget(Size size) {
    return SizedBox(
      height: size.height * 0.15,
      width: size.height * 0.15,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Moon glow effect
          Container(
            width: size.height * 0.15,
            height: size.height * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.25),
                  blurRadius: 25,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
          // Moon shape
          SizedBox(
            width: size.height * 0.13,
            height: size.height * 0.13,
            child: CustomPaint(
              painter: MoonPainter(),
            ),
          ),
          // Stars effect (optional)
          Positioned(
            right: 5,
            top: 15,
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 20,
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 3,
                    spreadRadius: 1,
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

class MoonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final moonColor = Colors.white.withOpacity(0.95);
    
    // Draw the moon shape
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));
    
    final shadowPath = Path();
    shadowPath.addOval(Rect.fromLTWH(
      size.width * 0.25, 
      size.height * -0.05, 
      size.width * 0.9, 
      size.height * 0.9
    ));
    
    // Use difference to create crescent moon shape
    final moonPath = Path.combine(
      PathOperation.difference,
      path,
      shadowPath,
    );
    
    final paint = Paint()
      ..color = moonColor
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(moonPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}