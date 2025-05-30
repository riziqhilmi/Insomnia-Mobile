import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatistikPage extends StatefulWidget {
  const StatistikPage({Key? key}) : super(key: key);

  @override
  _StatistikPageState createState() => _StatistikPageState();
}

class _StatistikPageState extends State<StatistikPage> {
  List<dynamic> userPredictions = [];
  bool isLoading = true;
  int? userId;

  final Color primaryColor = const Color(0xFF2D3250);
  final Color accentColor = const Color(0xFF7776BC);
  final Color backgroundColor = const Color(0xFFF4F4FF);
  final Color cardColor = const Color(0xFFE9E8FF);

  Map<String, int> predictionCount = {
    'Tidak Insomnia': 0,
    'Risiko Insomnia': 0,
    'Insomnia': 0,
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
    if (userId != null) {
      await fetchPredictions(userId!);
    }
  }

  Future<void> fetchPredictions(int id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/user_predictions/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final data = jsonData['data'] as List<dynamic>;

      setState(() {
        userPredictions = data;
        for (var pred in data) {
          final predictionValue = pred['prediction'];
          String result = '';
          switch (predictionValue) {
            case 0:
              result = 'Tidak Insomnia';
              break;
            case 1:
              result = 'Risiko Insomnia';
              break;
            case 2:
              result = 'Insomnia';
              break;
          }
          if (predictionCount.containsKey(result)) {
            predictionCount[result] = predictionCount[result]! + 1;
          }
        }
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      print('Gagal memuat data prediksi');
    }
  }

  Widget buildInsightCard() {
    String insightText = '';
    IconData insightIcon = Icons.info_outline;
    Color cardColor = Colors.blue.shade100;

    final maxLabel =
        predictionCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    switch (maxLabel) {
      case 'Tidak Insomnia':
        insightText =
            "Kamu tampaknya memiliki kualitas tidur yang baik. Pertahankan pola tidur sehatmu!";
        insightIcon = Icons.check_circle_outline;
        cardColor = Colors.green.shade100;
        break;
      case 'Risiko Insomnia':
        insightText =
            "Ada potensi gangguan tidur. Coba kurangi stres dan perhatikan waktu tidurmu.";
        insightIcon = Icons.warning_amber_rounded;
        cardColor = Colors.orange.shade100;
        break;
      case 'Insomnia':
        insightText =
            "Tingkat insomnia tinggi terdeteksi. Pertimbangkan untuk mengubah gaya hidup atau berkonsultasi.";
        insightIcon = Icons.health_and_safety_rounded;
        cardColor = Colors.red.shade100;
        break;
    }

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(insightIcon, size: 36, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                insightText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
      String label, int count, Color color, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 3,
        color: color.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            Text('$count kali', style: const TextStyle(fontSize: 16)),
          ]),
        ),
      ),
    );
  }

  List<BarChartGroupData> get barChartData {
    return [
      BarChartGroupData(x: 0, barRods: [
        BarChartRodData(
          fromY: 0,
          toY: predictionCount['Tidak Insomnia']!.toDouble(),
          color: Colors.green,
          width: 20,
          borderRadius: BorderRadius.circular(6),
        )
      ]),
      BarChartGroupData(x: 1, barRods: [
        BarChartRodData(
          fromY: 0,
          toY: predictionCount['Risiko Insomnia']!.toDouble(),
          color: Colors.orange,
          width: 20,
          borderRadius: BorderRadius.circular(6),
        )
      ]),
      BarChartGroupData(x: 2, barRods: [
        BarChartRodData(
          fromY: 0,
          toY: predictionCount['Insomnia']!.toDouble(),
          color: Colors.red,
          width: 20,
          borderRadius: BorderRadius.circular(6),
        )
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final total = predictionCount.values.reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Statistik Prediksi"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildSummaryCard(
                          'Tidak Insomnia',
                          predictionCount['Tidak Insomnia']!,
                          Colors.green,
                          Icons.bedtime_off),
                      const SizedBox(width: 10),
                      _buildSummaryCard(
                          'Risiko',
                          predictionCount['Risiko Insomnia']!,
                          Colors.orange,
                          Icons.warning_amber_rounded),
                      const SizedBox(width: 10),
                      _buildSummaryCard(
                          'Insomnia',
                          predictionCount['Insomnia']!,
                          Colors.red,
                          Icons.bedtime),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Card(
                    color: cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          const Text(
                            'Distribusi Prediksi Insomnia',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: predictionCount['Tidak Insomnia']!
                                        .toDouble(),
                                    title:
                                        'Tidak\n${predictionCount['Tidak Insomnia']}',
                                    radius: 60,
                                    titleStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.orange,
                                    value: predictionCount['Risiko Insomnia']!
                                        .toDouble(),
                                    title:
                                        'Risiko\n${predictionCount['Risiko Insomnia']}',
                                    radius: 60,
                                    titleStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.red,
                                    value:
                                        predictionCount['Insomnia']!.toDouble(),
                                    title:
                                        'Insomnia\n${predictionCount['Insomnia']}',
                                    radius: 60,
                                    titleStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                                sectionsSpace: 4,
                                centerSpaceRadius: 40,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Total Prediksi: $total',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 24),
                          buildInsightCard(), // << Tambahan insight
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    color: cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Text(
                            'Grafik Batang Prediksi Insomnia',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: BarChart(
                              BarChartData(
                                borderData: FlBorderData(show: false),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: true),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        switch (value.toInt()) {
                                          case 0:
                                            return const Text("Tidak");
                                          case 1:
                                            return const Text("Risiko");
                                          case 2:
                                            return const Text("Insomnia");
                                          default:
                                            return const Text('');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                barGroups: barChartData,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
