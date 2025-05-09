import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, __, ___) => const SuccessPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F2F),
      body: Stack(
        children: [
          // Partikel bintang
          AnimatedBackground(
            vsync: this,
            behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                baseColor: Colors.white.withOpacity(0.35),
                spawnOpacity: 0.0,
                opacityChangeRate: 0.25,
                minOpacity: 0.1,
                maxOpacity: 0.4,
                particleCount: 100,
                spawnMaxRadius: 4.0,
                spawnMinRadius: 1.0,
                spawnMaxSpeed: 30.0,
                spawnMinSpeed: 10.0,
              ),
            ),
            child: Container(),
          ),

          // Bulan
          const Positioned(
            top: 70,
            right: 40,
            child: Icon(Icons.nightlight_round, size: 80, color: Colors.white38),
          ),

          // Form Register
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.white.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.06),
                        blurRadius: 12,
                        spreadRadius: 4,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Icon(Icons.person_add_alt_1_rounded,
                            size: 72, color: Colors.white),
                        const SizedBox(height: 12),
                        const Text("Buat Akun Baru",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white60,
                                fontWeight: FontWeight.w300)),
                        const Text("Sign Up",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 36),

                        _buildInput(
                          controller: _nameController,
                          icon: Icons.person_outline,
                          hint: "Nama Lengkap",
                          validator: (val) => val!.isEmpty ? 'Nama tidak boleh kosong' : null,
                        ),
                        const SizedBox(height: 20),

                        _buildInput(
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          hint: "Email",
                          validator: (val) =>
                              val!.contains("@") ? null : 'Email tidak valid',
                        ),
                        const SizedBox(height: 20),

                        _buildInput(
                          controller: _passwordController,
                          icon: Icons.lock_outline,
                          hint: "Password",
                          obscure: !_isPasswordVisible,
                          suffix: _visibilityIcon(
                              _isPasswordVisible, () => setState(() => _isPasswordVisible = !_isPasswordVisible)),
                          validator: (val) =>
                              val!.length < 6 ? 'Minimal 6 karakter' : null,
                        ),
                        const SizedBox(height: 20),

                        _buildInput(
                          controller: _confirmPasswordController,
                          icon: Icons.lock_outline,
                          hint: "Konfirmasi Password",
                          obscure: !_isConfirmVisible,
                          suffix: _visibilityIcon(
                              _isConfirmVisible, () => setState(() => _isConfirmVisible = !_isConfirmVisible)),
                          validator: (val) => val != _passwordController.text
                              ? 'Password tidak cocok'
                              : null,
                        ),
                        const SizedBox(height: 30),

                        CustomButton(
                          text: "Daftar",
                          onPressed: _handleRegister,
                          gradient: const LinearGradient(
                            colors: [Colors.cyan, Colors.blueAccent],
                          ),
                        ),
                        const SizedBox(height: 25),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Sudah punya akun? ",
                                style: TextStyle(color: Colors.white)),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Masuk",
                                  style: TextStyle(
                                      color: Colors.cyanAccent,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white10,
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }

  Widget _visibilityIcon(bool visible, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(visible ? Icons.visibility : Icons.visibility_off,
          color: Colors.white70),
      onPressed: onPressed,
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F2F),
      body: const Center(
        child: Text(
          "Registrasi Berhasil!",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
