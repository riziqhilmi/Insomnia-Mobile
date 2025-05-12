import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController namaController = TextEditingController();
  final TextEditingController umurController = TextEditingController();
  final TextEditingController profesiController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background galaxy
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/galaxy_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay gelap
          Container(
            color: Colors.black.withOpacity(0.65),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Header
                  Row(
                    children: const [
                      Icon(Icons.bedtime, color: Colors.white),
                      SizedBox(width: 8),
                      Text("Insomnic",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Avatar dengan edit
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 60, color: Colors.grey[700]),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Edit Profil",
                      style: TextStyle(fontSize: 18, color: Colors.white)),

                  const SizedBox(height: 24),

                  // Form input menggunakan CustomTextField
                  CustomTextField(
                    icon: Icons.person,
                    hintText: "Nama Lengkap",
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    icon: Icons.cake,
                    hintText: "Umur",
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    icon: Icons.school,
                    hintText: "Profesi / Sekolah",
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
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
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Nav Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: "Prediksi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Saya"),
        ],
      ),
    );
  }
}
