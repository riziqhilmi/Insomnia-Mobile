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
  default:
    result = '';
}

if (predictionCount.containsKey(result)) {
  predictionCount[result] = predictionCount[result]! + 1;
}

        }

        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Gagal memuat data prediksi');
    }
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
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              value: predictionCount['Tidak Insomnia']!.toDouble(),
                              title: 'Tidak\n${predictionCount['Tidak Insomnia']}',
                              radius: 60,
                              titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            PieChartSectionData(
                              color: Colors.orange,
                              value: predictionCount['Risiko Insomnia']!.toDouble(),
                              title: 'Risiko\n${predictionCount['Risiko Insomnia']}',
                              radius: 60,
                              titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            PieChartSectionData(
                              color: Colors.red,
                              value: predictionCount['Insomnia']!.toDouble(),
                              title: 'Insomnia\n${predictionCount['Insomnia']}',
                              radius: 60,
                              titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                  ],
                ),
              ),
            ),
    );
  }
}
