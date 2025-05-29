import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'register_screen.dart';
import '../page/home_page.dart';
import 'forgot_password.dart';
import 'package:http/http.dart' as myhttp;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0C1446),
              Color(0xFF1E2F97),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(Icons.nights_stay, size: 72, color: Colors.white),
                const SizedBox(height: 16),
                 Text(
                  "selamat datang kembali".tr,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  "masuk ke akun anda".tr,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: emailC,
                  icon: Icons.email_outlined,
                  hintText: "masukkan email anda".tr,
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: passwordC,
                  icon: Icons.lock_outline,
                  hintText: "masukkan kata sandi anda".tr,
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()),
                    );
                  },
                  child:  Text(
                    "lupa kata sandi?".tr,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "masuk".tr,
                  onPressed: () {
                    handleLogin(context, emailC, passwordC);
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "belum punya akun?".tr,
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child:  Text(
                        "daftar".tr,
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool checkEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

Future<void> handleLogin(BuildContext context, TextEditingController emailC,
    TextEditingController passwordC) async {
  try {
    if (!checkEmail(emailC.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          showCloseIcon: true,
          content: Text('email tidak valid'.tr),
        ),
      );
      return;
    }

    var responses = await myhttp.post(
      Uri.parse('http://localhost:5000/login'), 
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': emailC.text,
        'password': passwordC.text,
      }),
    );

    if (!context.mounted) return;

    if (responses.statusCode == 200) {
      Map<String, dynamic> data = json.decode(responses.body);

      if (data['status'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        final int userId = data['user']['id'];
        await prefs.setInt('user_id', userId);
        print('User ID disimpan: $userId'); // Untuk debug

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('login berhasil!'.tr),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(data['message'] ?? 'login gagal'.tr),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          backgroundColor: Colors.red,
          content: Text('login gagal, silakan coba lagi'.tr),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('terjadi kesalahan saat login'.tr),
      ),
    );
    print('Login error: $e'); // Debug error
  }
}
