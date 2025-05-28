import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final loadedUserId = prefs.getInt('user_id');
    
    if (loadedUserId != null) {
      setState(() {
        userId = loadedUserId;
      });
      await _loadUserPredictions();
    }
  }

  Future<void> _loadUserPredictions() async {
    // Simulasi pengambilan data - dalam implementasi nyata ganti dengan API call
    final allPredictions = await _fetchAllPredictions();
    
    setState(() {
      userPredictions = allPredictions.where((pred) => pred['user_id'] == userId).toList();
      isLoading = false;
    });
  }

  // Fungsi simulasi pengambilan data
  Future<List<dynamic>> _fetchAllPredictions() async {
    // Contoh data - ganti dengan API call ke backend Anda
    return [
      {
        "_id": {"\$oid": "6835fccdc51aba12ac57383f"},
        "user_id": 9,
        "input": {
          "sleep_hours": "4-5 jam",
          "sleep_quality": "Cukup",
          "stress": "Stress tinggi"
        },
        "mapped_input": {
          "sleep_hours": "4-5 hours",
          "sleep_quality": "Average",
          "stress": "High stress",
          "device_use": "Rarely (1-2 times a week)"
        },
        "prediction": 1,
        "result": "Insomnia ringan",
        "timestamp": {"\$date": "2025-05-27T17:56:29.841Z"}
      },
      {
        "_id": {"\$oid": "68366254d2ecb7e24fffb02e"},
        "user_id": 9,
        "input": {
          "sleep_hours": "Kurang dari 4 jam",
          "sleep_quality": "Cukup",
          "stress": "Stress sedang"
        },
        "mapped_input": {
          "sleep_hours": "Less than 4 hours",
          "sleep_quality": "Average",
          "stress": "Moderate",
          "device_use": "Often (5-6 times a week)"
        },
        "prediction": 0,
        "result": "Tidak ada insomnia",
        "timestamp": {"\$date": "2025-05-28T01:09:40.603Z"}
      },
      // Tambahkan data lain sesuai kebutuhan
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || userId == null) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.nightlight_rounded, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Insomnic',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 20, bottom: 30, left: 20, right: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistik Tidur',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pantau pola tidur Anda',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildQuickStat(
                        _calculateAverageSleepHours().toStringAsFixed(1),
                        'Jam',
                        Icons.access_time,
                      ),
                      _buildQuickStat(
                        '${_calculateInsomniaPercentage().round()}%',
                        'Insomnia',
                        Icons.nightlight_round,
                      ),
                      _buildQuickStat(
                        _getMostCommonWakeTime(),
                        'Bangun',
                        Icons.wb_twighlight,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Visualisasi personal user
            _buildUserInsomniaSummary(),
            _buildUserInsomniaTimeline(),
            _buildUserSleepPatterns(),
            _buildUserRiskFactors(),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Fungsi helper untuk statistik header
  double _calculateAverageSleepHours() {
    if (userPredictions.isEmpty) return 0;
    
    double total = 0;
    for (var pred in userPredictions) {
      final hours = pred['mapped_input']['sleep_hours'];
      if (hours == 'Less than 4 hours') total += 3.5;
      else if (hours == '4-5 hours') total += 4.5;
      else if (hours == '6-7 hours') total += 6.5;
      else total += 7.5;
    }
    return total / userPredictions.length;
  }

  double _calculateInsomniaPercentage() {
    if (userPredictions.isEmpty) return 0;
    final insomniaCases = userPredictions.where((d) => d['prediction'] == 1).length;
    return (insomniaCases / userPredictions.length) * 100;
  }

  String _getMostCommonWakeTime() {
    if (userPredictions.isEmpty) return '-';
    
    final wakeTimes = groupBy(userPredictions, (d) => d['mapped_input']['night_wake']);
    final mostCommon = wakeTimes.entries.reduce((a, b) => a.value.length > b.value.length ? a : b);
    
    switch (mostCommon.key) {
      case 'Every night': return 'Sering';
      case 'Sometimes (3-4 times a week)': return 'Kadang';
      case 'Rarely (1-2 times a week)': return 'Jarang';
      default: return '-';
    }
  }

  Widget _buildQuickStat(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Visualisasi personal user
  Widget _buildUserInsomniaSummary() {
    final totalPredictions = userPredictions.length;
    final insomniaCases = userPredictions.where((d) => d['prediction'] == 1).length;
    final percentage = totalPredictions == 0 ? 0 : (insomniaCases / totalPredictions * 100).round();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Riwayat Prediksi Insomnia Anda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3250),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildUserStatCard(
                'Total Prediksi',
                '$totalPredictions',
                Icons.assignment,
                accentColor,
              ),
              _buildUserStatCard(
                'Insomnia Ringan',
                '$insomniaCases ($percentage%)',
                Icons.nightlight_round,
                const Color(0xFFFF6B6B),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: insomniaCases.toDouble(),
                    color: const Color(0xFFFF6B6B),
                    title: '$percentage%',
                    radius: 60,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    value: (totalPredictions - insomniaCases).toDouble(),
                    color: const Color(0xFF4ECDC4),
                    title: '${100 - percentage}%',
                    radius: 60,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserStatCard(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildUserInsomniaTimeline() {
    final predictionsByDate = groupBy(userPredictions, (pred) {
      final date = DateTime.parse(pred['timestamp']['\$date']);
      return '${date.day}/${date.month}';
    });

    final dates = predictionsByDate.keys.toList();
    final insomniaCounts = dates.map((date) {
      return predictionsByDate[date]!.where((p) => p['prediction'] == 1).length;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Perkembangan Prediksi Anda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3250),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: dates.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), insomniaCounts[entry.key].toDouble());
                    }).toList(),
                    isCurved: true,
                    color: const Color(0xFFFF6B6B),
                    barWidth: 4,
                    belowBarData: BarAreaData(show: true, color: const Color(0xFFFF6B6B).withOpacity(0.3)),
                    dotData: FlDotData(show: true),
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() < dates.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(dates[value.toInt()]),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toInt().toString());
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserSleepPatterns() {
    final insomniaPredictions = userPredictions.where((p) => p['prediction'] == 1).toList();
    
    final sleepHoursData = insomniaPredictions.map((p) {
      final hours = p['mapped_input']['sleep_hours'];
      if (hours == 'Less than 4 hours') return 3.5;
      if (hours == '4-5 hours') return 4.5;
      if (hours == '6-7 hours') return 6.5;
      return 7.5;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pola Tidur Saat Insomnia',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3250),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                barGroups: sleepHoursData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value,
                        color: accentColor,
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }).toList(),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text('Tes ${value.toInt() + 1}');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()} jam');
                      },
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

  Widget _buildUserRiskFactors() {
    final insomniaPredictions = userPredictions.where((p) => p['prediction'] == 1).toList();
    
    int highStress = insomniaPredictions.where((p) => p['mapped_input']['stress'] == 'High stress').length;
    int poorSleepQuality = insomniaPredictions.where((p) => p['mapped_input']['sleep_quality'] == 'Poor').length;
    int deviceUsage = insomniaPredictions.where((p) => p['mapped_input']['device_use'].contains('Often')).length;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Faktor Risiko Anda',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3250),
            ),
          ),
          const SizedBox(height: 16),
          _buildRiskFactorItem(
            'Tingkat Stres',
            highStress,
            insomniaPredictions.length,
            Icons.emoji_emotions_outlined,
            const Color(0xFFFF6B6B),
          ),
          _buildRiskFactorItem(
            'Kualitas Tidur',
            poorSleepQuality,
            insomniaPredictions.length,
            Icons.bedtime_outlined,
            accentColor,
          ),
          _buildRiskFactorItem(
            'Penggunaan Device',
            deviceUsage,
            insomniaPredictions.length,
            Icons.phone_iphone,
            const Color(0xFF4ECDC4),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskFactorItem(String title, int count, int total, IconData icon, Color color) {
    final percentage = total == 0 ? 0 : (count / total * 100).round();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: Colors.grey[200],
                  color: color,
                  minHeight: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '$percentage%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}