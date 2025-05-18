import 'package:flutter/material.dart';

class TipsTidurPage extends StatelessWidget {
  const TipsTidurPage({super.key});

  final List<String> tipsTidur = const [
    'Tidur dan bangun di waktu yang sama setiap hari.',
    'Hindari kafein dan alkohol menjelang tidur.',
    'Ciptakan suasana kamar yang tenang, gelap, dan sejuk.',
    'Hindari penggunaan gadget 1 jam sebelum tidur.',
    'Lakukan relaksasi seperti meditasi atau pernapasan dalam.',
    'Batasi tidur siang maksimal 30 menit.',
    'Rutin berolahraga, tetapi hindari olahraga berat menjelang tidur.',
    'Gunakan kasur dan bantal yang nyaman.',
    'Jika tidak bisa tidur, bangunlah dan lakukan aktivitas ringan.',
    'Buat rutinitas sebelum tidur, seperti membaca atau mandi air hangat.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF6F6F6),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tips Tidur Sehat',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tipsTidur.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            tipsTidur[index],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      },
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
