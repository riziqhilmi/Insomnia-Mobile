import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2D3250);
    const Color accentColor = Color(0xFF7776BC);
    const Color backgroundColor = Color(0xFFF4F4FF);
    const Color cardColor = Color(0xFFE9E8FF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // kembali ke halaman sebelumnya
          },
        ),
        title:  Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'tentang aplikasi'.tr,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Insomnic',
                    style: TextStyle(
                      color: Color(0xFF2D3250),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'versi: 1.0.0'.tr,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'insomnic adalah aplikasi yang dirancang untuk membantu pengguna memahami dan mengatasi masalah insomnia. aplikasi ini menyediakan informasi seputar pola tidur, edukasi, prediksi kualitas tidur, serta grafik statistik yang mudah dipahami.'.tr,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(height: 20),
            _buildInfoTile(
              icon: Icons.person,
              title: 'dikembangkan oleh'.tr,
              subtitle: 'tim insomnic'.tr,
              iconColor: accentColor,
            ),
             SizedBox(height: 10),
            _buildInfoTile(
              icon: Icons.mail_outline,
              title: 'kontak'.tr,
              subtitle: '-',
              iconColor: accentColor,
            ),
             SizedBox(height: 10),
            _buildInfoTile(
              icon: Icons.lock_outline,
              title: 'hak cipta'.tr,
              subtitle: '-',
              iconColor: accentColor,
            ),
             SizedBox(height: 10),
            _buildInfoTile(
              icon: Icons.privacy_tip_outlined,
              title: 'kebijakan privasi'.tr,
              subtitle:
                  'data pengguna tidak disimpan atau dibagikan ke pihak ketiga.'.tr,
              iconColor: accentColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE9E8FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF2D3250),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
