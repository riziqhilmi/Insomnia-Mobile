import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../screens/login_screen.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/security_privacy_screen.dart';
import '/page/home_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Data sementara untuk debugging (ganti dengan data dinamis dari state management atau penyimpanan)
  final String username = "darunganari";
  final String phone = "081234567890";
  final String email = "darunganari@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
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
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 40),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$username\n$email',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              height: 400,
              decoration: const BoxDecoration(
                color: Color(0xFF1B263B),
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
                  _buildButton(context, 'Edit Profil Pengguna', Icons.edit, isEditProfile: true),
                  _buildButton(context, 'Keamanan & privasi', Icons.lock, isSecurity: true),
                  _buildButton(context, 'Peraturan notifikasi', Icons.notifications),
                  _buildButton(context, 'Tentang Aplikasi', Icons.info),
                  _buildButton(context, 'Keluar Akun', Icons.logout, isLogout: true),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1B263B),
        selectedItemColor: Colors.deepPurple[800],
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Get.to(() => const HomePage());
          } else if (index == 1) {
            // Tambahkan navigasi ke halaman prediksi jika ada
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Prediksi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Saya'),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, IconData icon, {bool isLogout = false, bool isEditProfile = false, bool isSecurity = false}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () {
          if (isLogout) {
            // Navigasi ke halaman LoginScreen dengan menghapus semua halaman sebelumnya
            Get.offAll(() => const LoginScreen());
          } else if (isEditProfile) {
            // Navigasi ke EditProfileScreen
            Get.to(() => const EditProfileScreen());
          } else if (isSecurity) {
            // Navigasi ke SecurityPrivacyScreen dengan parameter wajib
            Get.to(() => SecurityPrivacyScreen(
                  username: username,
                  phone: _maskPhoneNumber(phone),
                  email: _maskEmail(email),
                ));
          } else {
            // Logika lainnya jika bukan tombol logout
            Get.snackbar('Info', 'Fitur $title belum diimplementasikan');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple[600],
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk masking nomor telepon
  String _maskPhoneNumber(String phone) {
    if (phone.length < 4) return phone;
    return "${phone.substring(0, phone.length - 4)}****";
  }

  // Fungsi untuk masking email
  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts[0].length < 3) return email;
    return "${parts[0].substring(0, 2)}********@${parts[1]}";
  }
}