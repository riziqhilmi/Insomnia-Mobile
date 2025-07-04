import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:animated_background/animated_background.dart';
import 'package:insomnia_app/screens/login_screen.dart';
import 'package:insomnia_app/utils/base-url.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
  with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final namaDepanC = TextEditingController();
  final usernameC = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _gender;
  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final uri = Uri.parse("$url/register");

    final Map<String, dynamic> body = {
      "name": namaDepanC.text,
      "username": usernameC.text,
      "jenis_kelamin": _gender,
      "tanggal_lahir": _birthDateController.text,
      "telepon": _phoneController.text,
      "role": "user",
      "email": _emailController.text,
      "password": _passwordController.text,
    };

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: const Color(0xFF0B0F2F),
            title:Text("berhasil".tr, style: TextStyle(color: Colors.white)),
            content: Text(data['message'] ?? "registrasi berhasil!".tr,
                style: const TextStyle(color: Colors.white70)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text("OK",
                    style: TextStyle(color: Colors.cyanAccent)),
              )
            ],
          ),
        );
      } else {
        _showError(data['message'] ?? "registrasi gagal coba lagi.".tr);
      }
    } catch (e) {
      _showError("terjadi kesalahan saat menghubungi server.".tr);
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF0B0F2F),
        title:  Text("gagal".tr, style: TextStyle(color: Colors.white)),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Colors.cyanAccent)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    namaDepanC.dispose();
    usernameC.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F2F),
      body: Stack(
        children: [
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
          const Positioned(
            top: 70,
            right: 40,
            child:
                Icon(Icons.nightlight_round, size: 80, color: Colors.white38),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.white.withOpacity(0.05)
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
                        Text("buat akun baru".tr,
                            style:
                                TextStyle(fontSize: 16, color: Colors.white60)),
                        Text("mendaftar".tr,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 36),
                        _buildInput(
                            controller: namaDepanC,
                            icon: Icons.person_outline,
                            hint: "nama lengkap".tr,
                            validator: (val) => val!.isEmpty
                                ? 'nama tidak boleh kosong'.tr
                                : null),
                        const SizedBox(height: 20),
                        _buildInput(
                            controller: usernameC,
                            icon: Icons.person_outline,
                            hint: "nama belakang".tr,
                            validator: (val) => val!.isEmpty
                                ? 'nama belakang tidak boleh kosong'.tr
                                : null),
                        const SizedBox(height: 20),
                        _buildInput(
                            controller: null,
                            icon: Icons.person_outline,
                            hint: "jenis Kelamin".tr
                            ,
                            validator: (val) =>
                                val == null ? 'pilih jenis kelamin'.tr: null,
                            dropdownItems:  [
                              DropdownMenuItem(
                                  value: "laki-laki".tr, child: Text("laki-laki".tr)),
                              DropdownMenuItem(
                                  value: "perempuan".tr, child: Text("perempuan".tr)),
                            ]),
                        const SizedBox(height: 20),
                        _buildInput(
                            controller: _birthDateController,
                            icon: Icons.calendar_today,
                            hint: "tanggal lahir".tr,
                            isDatePicker: true,
                            validator: (val) => val!.isEmpty
                                ? 'tanggal lahir wajib diisi'.tr
                                : null),
                        const SizedBox(height: 20),
                        _buildInput(
                            controller: _phoneController,
                            icon: Icons.phone,
                            hint: "nomor telepon".tr,
                            validator: (val) =>
                                val!.isEmpty ? 'telepon wajib diisi'.tr : null),
                        const SizedBox(height: 20),
                        _buildInput(
                            controller: _emailController,
                            icon: Icons.email_outlined,
                            hint: "email".tr,
                            validator: (val) => val!.contains("@")
                                ? null
                                : 'email tidak valid'.tr),
                        const SizedBox(height: 20),
                        _buildInput(
                            controller: _passwordController,
                            icon: Icons.lock_outline,
                            hint: "kata sandi".tr,
                            obscure: !_isPasswordVisible,
                            suffix: _visibilityIcon(_isPasswordVisible, () {
                              setState(() =>
                                  _isPasswordVisible = !_isPasswordVisible);
                            }),
                            validator: (val) =>
                                val!.length < 6 ? 'minimal 6 karakter'.tr : null),
                        const SizedBox(height: 20),
                        _buildInput(
                            controller: _confirmPasswordController,
                            icon: Icons.lock_outline,
                            hint: "konfirmasi kata sandi".tr,
                            obscure: !_isConfirmVisible,
                            suffix: _visibilityIcon(_isConfirmVisible, () {
                              setState(
                                  () => _isConfirmVisible = !_isConfirmVisible);
                            }),
                            validator: (val) => val != _passwordController.text
                                ? 'kata sandi tidak cocok'.tr
                                : null),
                        const SizedBox(height: 30),
                        CustomButton(
                          text: "daftar".tr,
                          onPressed: _handleRegister,
                          gradient: const LinearGradient(
                              colors: [Colors.cyan, Colors.blueAccent]),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("sudah punya akun?".tr,
                                style: TextStyle(color: Colors.white)),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child:  Text("masuk".tr,
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
          ),
        ],
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController? controller,
    required IconData icon,
    required String hint,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
    bool isDatePicker = false,
    List<DropdownMenuItem<String>>? dropdownItems,
  }) {
    if (isDatePicker) {
      return GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            decoration: _inputDecoration(icon, hint),
            style: const TextStyle(color: Colors.white),
            validator: validator,
            enabled: false,
          ),
        ),
      );
    } else if (dropdownItems != null) {
      return DropdownButtonFormField<String>(
        value: _gender != null &&
                dropdownItems.any((item) => item.value == _gender)
            ? _gender
            : null,
        decoration: _inputDecoration(icon, hint),
        style: const TextStyle(color: Colors.white),
        dropdownColor: const Color(0xFF0B0F2F),
        items: dropdownItems,
        onChanged: (value) => setState(() => _gender = value),
        validator: validator,
      );
    } else {
      return TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        keyboardType:
            hint == "Nomor Telepon" ? TextInputType.phone : TextInputType.text,
        decoration: _inputDecoration(icon, hint).copyWith(suffixIcon: suffix),
      );
    }
  }

  InputDecoration _inputDecoration(IconData icon, String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white10,
      prefixIcon: Icon(icon, color: Colors.white70),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
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
