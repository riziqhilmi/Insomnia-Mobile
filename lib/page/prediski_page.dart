import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SleepClassificationPage extends StatefulWidget {
  const SleepClassificationPage({Key? key}) : super(key: key);

  @override
  State<SleepClassificationPage> createState() =>
      _SleepClassificationPageState();
}

class _SleepClassificationPageState extends State<SleepClassificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();

  // Form values
  String? _year;
  String? _gender;
  String? _sleepDifficulty;
  String? _sleepHours;
  String? _nightWake;
  String? _sleepQuality;
  String? _concentration;
  String? _fatigue;
  String? _missClass;
  String? _impactAssignment;
  String? _deviceUse;
  String? _caffeine;
  String? _exercise;
  String? _stress;
  String? _performance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageController.page!.toInt() < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _tabController.animateTo(_pageController.page!.toInt() + 1);
    } else {
      _processClassification();
    }
  }

  void _previousPage() {
    if (_pageController.page!.toInt() > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _tabController.animateTo(_pageController.page!.toInt() - 1);
    }
  }

  Future<void> _processClassification() async {
    // Validasi semua field terisi
    if (_year == null ||
        _gender == null ||
        _sleepDifficulty == null ||
        _sleepHours == null ||
        _nightWake == null ||
        _sleepQuality == null ||
        _concentration == null ||
        _fatigue == null ||
        _missClass == null ||
        _impactAssignment == null ||
        _deviceUse == null ||
        _caffeine == null ||
        _exercise == null ||
        _stress == null ||
        _performance == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E2746),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Data Tidak Lengkap',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Harap isi semua field sebelum melakukan klasifikasi.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      );
      return;
    }

    // Tampilkan loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurple,
        ),
      ),
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      final int? userId =
          prefs.getInt('user_id'); // pastikan key ini sama saat simpan

      if (userId == null) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E2746),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'User Tidak Ditemukan',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'User ID tidak ditemukan, silakan login ulang.',
              style: TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            ],
          ),
        );
        return;
      }

      // Buat request object
      final request = {
        'user_id': userId,
        'year': _year,
        'gender': _gender,
        'sleep_difficulty': _sleepDifficulty,
        'sleep_hours': _sleepHours,
        'night_wake': _nightWake,
        'sleep_quality': _sleepQuality,
        'concentration': _concentration,
        'fatigue': _fatigue,
        'miss_class': _missClass,
        'impact_assignment': _impactAssignment,
        'device_use': _deviceUse,
        'caffeine': _caffeine,
        'exercise': _exercise,
        'stress': _stress,
        'performance': _performance,
      };

      // Panggil API
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/predict'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request),
      );

      // Tutup loading indicator
      Navigator.pop(context);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _showResultDialog(data);
      } else {
        throw Exception('Failed to get prediction: ${response.statusCode}');
      }
    } catch (e) {
      // Tutup loading indicator jika ada error
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E2746),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Error',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Terjadi kesalahan: $e',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _showResultDialog(Map<String, dynamic> response) {
    String resultText;
    Color resultColor;

    switch (response['prediction']) {
      case 0:
        resultText = 'Tidak ada insomnia';
        resultColor = Colors.green;
        break;
      case 1:
        resultText = 'Risiko Insomnia';
        resultColor = Colors.orange;
        break;
      case 2:
        resultText = 'Insomnia';
        resultColor = Colors.red;
        break;
      default:
        resultText = 'Hasil tidak diketahui';
        resultColor = Colors.grey;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2746),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Hasil Klasifikasi',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF131C3D),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: resultColor.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    resultText,
                    style: TextStyle(
                      color: resultColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tingkat insomnia: ${response['prediction']}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${response['result']}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1128),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Klasifikasi Tidur',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF342D7E), Color(0xFF0A1128)],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [
              const SizedBox(height: 8),
              TabBar(
                controller: _tabController,
                onTap: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                indicator: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(50),
                ),
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline, size: 18),
                        SizedBox(width: 8),
                        Text('Profil'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.nightlight_round, size: 18),
                        SizedBox(width: 8),
                        Text('Kebiasaan'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bedtime_outlined, size: 18),
                        SizedBox(width: 8),
                        Text('Tidur'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.psychology_outlined, size: 18),
                        SizedBox(width: 8),
                        Text('Kondisi'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
        children: [
          _buildProfilePage(),
          _buildHabitsPage(),
          _buildSleepPage(),
          _buildConditionsPage(),
        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Profil Anda', Icons.person),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Tahun Akademik',
            hint: 'Pilih tahun akademik',
            value: _year,
            items: const [
              'Tahun Pertama',
              'Tahun Kedua',
              'Tahun Ketiga',
              'Mahasiswa PascaSarjana',
            ],
            onChanged: (val) => setState(() => _year = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Jenis Kelamin',
            hint: 'Pilih jenis kelamin',
            value: _gender,
            items: const ['Laki-laki', 'Perempuan'],
            onChanged: (val) => setState(() => _gender = val),
          ),
          const SizedBox(height: 40),
          _buildNavigationButtons(isFirstPage: true),
        ],
      ),
    );
  }

  Widget _buildHabitsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Kebiasaan Sehari-hari', Icons.nightlight_round),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Penggunaan Perangkat Sebelum Tidur',
            hint: 'Pilih frekuensi',
            value: _deviceUse,
            items: const [
              'Tidak Pernah',
              'Jarang',
              'Kadang-kadang',
              'Sering',
              'Selalu'
            ],
            onChanged: (val) => setState(() => _deviceUse = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Konsumsi Kafein',
            hint: 'Pilih frekuensi',
            value: _caffeine,
            items: const [
              'Tidak pernah',
              'Jarang (1-2 kali/minggu)',
              'Kadang-kadang (3-4/minggu)',
              'Sering (5-6 kali/minggu)',
              'Setiap hari'
            ],
            onChanged: (val) => setState(() => _caffeine = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Aktivitas Olahraga',
            hint: 'Pilih frekuensi',
            value: _exercise,
            items: const [
              'Tidak pernah',
              'Jarang (1-2 kali/minggu)',
              'Kadang-kadang (3-4/minggu)',
              'Sering (5-6 kali/minggu)',
              'Setiap hari'
            ],
            onChanged: (val) => setState(() => _exercise = val),
          ),
          const SizedBox(height: 40),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildSleepPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Kebiasaan Tidur', Icons.bedtime_outlined),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Kesulitan Tidur',
            hint: 'Pilih frekuensi',
            value: _sleepDifficulty,
            items: const [
              'Tidak Pernah',
              'Jarang',
              'Kadang-kadang',
              'Sering',
              'Selalu'
            ],
            onChanged: (val) => setState(() => _sleepDifficulty = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Lama Tidur (jam)',
            hint: 'Pilih lama tidur',
            value: _sleepHours,
            items: const [
              'Lebih dari 8 jam',
              '7-8 jam',
              '6-7 jam',
              '5-6 jam',
              '4-5 jam',
              'Kurang dari 4 jam',
              'Kurang dari 5 jam'
            ],
            onChanged: (val) => setState(() => _sleepHours = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Terbangun di Malam Hari',
            hint: 'Pilih frekuensi',
            value: _nightWake,
            items: const [
              'Tidak Pernah',
              'Jarang',
              'Kadang-kadang',
              'Sering',
              'Selalu'
            ],
            onChanged: (val) => setState(() => _nightWake = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Kualitas Tidur',
            hint: 'Pilih kualitas tidur',
            value: _sleepQuality,
            items: const [
              'Sangat baik',
              'Baik',
              'Cukup',
              'Buruk',
              'Sangat buruk'
            ],
            onChanged: (val) => setState(() => _sleepQuality = val),
          ),
          const SizedBox(height: 40),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildConditionsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Kondisi Mental', Icons.psychology_outlined),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Kesulitan Konsentrasi',
            hint: 'Pilih frekuensi',
            value: _concentration,
            items: const [
              'Tidak Pernah',
              'Jarang',
              'Kadang-kadang',
              'Sering',
              'Selalu'
            ],
            onChanged: (val) => setState(() => _concentration = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Kelelahan',
            hint: 'Pilih frekuensi',
            value: _fatigue,
            items: const [
              'Tidak Pernah',
              'Jarang',
              'Kadang-kadang',
              'Sering',
              'Selalu'
            ],
            onChanged: (val) => setState(() => _fatigue = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Ketidakhadiran Kuliah',
            hint: 'Pilih frekuensi',
            value: _missClass,
            items: const [
              'Tidak Pernah',
              'Jarang(1-2 kali/bulan)',
              'Kadang-kadang',
              'Sering'
            ],
            onChanged: (val) => setState(() => _missClass = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Dampak pada Tugas',
            hint: 'Pilih tingkat dampak',
            value: _impactAssignment,
            items: const [
              'Tidak berpengaruh',
              'Sedikit berpengaruh',
              'Cukup berpengaruh',
              'Sangat berpengaruh',
              'Berdampak parah'
            ],
            onChanged: (val) => setState(() => _impactAssignment = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Tingkat Stres',
            hint: 'Pilih tingkat stres',
            value: _stress,
            items: const [
              'Tidak Stress',
              'Stress rendah',
              'Stress sedang',
              'Stress tinggi',
              'Sangat tinggi',
              'Esktrem'
            ],
            onChanged: (val) => setState(() => _stress = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Performa Akademik',
            hint: 'Pilih performa',
            value: _performance,
            items: const [
              'Sangat baik',
              'Baik',
              'Cukup',
              'Dibawah rata-rata',
              'Buruk'
            ],
            onChanged: (val) => setState(() => _performance = val),
          ),
          const SizedBox(height: 40),
          _buildNavigationButtons(isLastPage: true),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF342D7E), Color(0xFF6A5ACD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String title,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF131C3D),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.deepPurple.withOpacity(0.3),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text(
                  hint,
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                icon:
                    const Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                isExpanded: true,
                dropdownColor: const Color(0xFF131C3D),
                style: const TextStyle(color: Colors.white),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons({
    bool isFirstPage = false,
    bool isLastPage = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isFirstPage)
          ElevatedButton.icon(
            onPressed: _previousPage,
            icon: const Icon(Icons.arrow_back_ios, size: 16),
            label: const Text('Sebelumnya'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          )
        else
          const SizedBox.shrink(),
        ElevatedButton.icon(
          onPressed: _nextPage,
          label: Text(isLastPage ? 'Klasifikasi' : 'Lanjut'),
          icon: Icon(
            isLastPage ? Icons.check_circle : Icons.arrow_forward_ios,
            size: 16,
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: isLastPage ? Colors.green : Colors.deepPurple,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}
