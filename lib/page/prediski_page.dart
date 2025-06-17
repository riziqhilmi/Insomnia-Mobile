import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:insomnia_app/utils/base-url.dart';
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
          title:  Text(
            'data tidak lengkap'.tr,
            style: TextStyle(color: Colors.white),
          ),
          content:  Text(
            'harap isi semua field sebelum melakukan klasifikasi.'.tr,
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
        Uri.parse('$url/predict'),
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
            'terjadi kesalahan: $e'.tr,
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
    String? tips;
    bool showTipsButton = true;

    switch (response['prediction']) {
      case 0:
        resultText = 'tidak ada insomnia'.tr;
        resultColor = Colors.green;
        showTipsButton = false; // Tidak menampilkan tombol Tips untuk hasil ini
        break;
      case 1:
        resultText = 'risiko insomnia'.tr;
        resultColor = Colors.orange;
        tips = '''
• coba tidur dan bangun di waktu yang sama setiap hari
• kurangi konsumsi kafein terutama di sore/malam hari
• buat lingkungan tidur yang nyaman (gelap, sejuk, tenang)
• lakukan aktivitas relaksasi sebelum tidur
• batasi waktu tidur siang maksimal 30 menit
'''.tr;
        break;
      case 2:
        resultText = 'Insomnia';
        resultColor = Colors.red;
        tips = '''
• Konsultasikan dengan dokter atau profesional kesehatan
• Hindari penggunaan tempat tidur untuk aktivitas selain tidur
• Kelola stres dengan teknik relaksasi
• Pertimbangkan untuk membuat jurnal tidur
• Hindari alkohol dan nikotin yang dapat mengganggu tidur
'''.tr;
        break;
      default:
        resultText = 'hasil tidak diketahui'.tr;
        resultColor = Colors.grey;
        tips = 'tidak ada tips yang tersedia untuk hasil ini'.tr;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2746),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'hasil klasifikasi'.tr,
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
                    'tingkat insomnia: ${response['prediction']}'.tr,
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
            if (showTipsButton) ...[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the result dialog
                  _showTipsDialog(tips!, resultColor); // Show tips dialog
                },
                child: const Text('Tips'),
              ),
              const SizedBox(height: 12),
            ],
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
              child: Text('kembali'.tr),
            ),
          ],
        ),
      ),
    );
  }

  void _showTipsDialog(String tips, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2746),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: color.withOpacity(0.5), width: 2),
        ),
        title:  Text(
          'tips untuk anda'.tr,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Text(
            tips,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text(
              'tutup'.tr,
              style: TextStyle(color: Colors.deepPurple),
            ),
          ),
        ],
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
        title: Text(
          'klasifikasi tidur'.tr,
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
                tabs:  [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline, size: 18),
                        SizedBox(width: 8),
                        Text('profil'.tr),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.nightlight_round, size: 18),
                        SizedBox(width: 8),
                        Text('kebiasaan'.tr),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bedtime_outlined, size: 18),
                        SizedBox(width: 8),
                        Text('tidur'.tr),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.psychology_outlined, size: 18),
                        SizedBox(width: 8),
                        Text('kondisi'.tr),
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
          _buildSectionHeader('profil anda'.tr, Icons.person),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'tahun akademik'.tr,
            hint: 'pilih tahun akademik'.tr,
            value: _year,
            items: [
              'tahun pertama'.tr,
              'tahun kedua'.tr,
              'tahun ketiga'.tr,
              'mahasiswa pascasarjana'.tr,
            ],
            onChanged: (val) => setState(() => _year = val),
          ),
           SizedBox(height: 16),
          _buildDropdownField(
            title: 'jenis Kelamin'.tr,
            hint: 'pilih jenis kelamin'.tr,
            value: _gender,
            items:  ['laki-laki'.tr, 'perempuan'.tr],
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
          _buildSectionHeader('kebiasaan sehari-hari'.tr, Icons.nightlight_round),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'penggunaan perangkat sebelum tidur'.tr,
            hint: 'pilih frekuensi'.tr,
            value: _deviceUse,
            items:  [
              'tidak pernah'.tr,
              'jarang'.tr,
              'kadang-kadang'.tr,
              'sering'.tr,
              'selalu'.tr
            ],
            onChanged: (val) => setState(() => _deviceUse = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'konsumsi kafein'.tr,
            hint: 'pilih frekuensi'.tr,
            value: _caffeine,
            items:  [
              'tidak pernah'.tr,
              'jarang (1-2 kali/minggu)'.tr,
              'kadang-kadang (3-4/minggu)'.tr,
              'sering (5-6 kali/minggu)'.tr,
              'setiap hari'.tr
            ],
            onChanged: (val) => setState(() => _caffeine = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'aktivitas olahraga'.tr,
            hint: 'pilih frekuensi'.tr,
            value: _exercise,
            items:  [
              'tidak pernah'.tr,
              'jarang (1-2 kali/minggu)'.tr,
              'kadang-kadang (3-4/minggu)'.tr,
              'sering (5-6 kali/minggu)'.tr,
              'setiap hari'.tr
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
          _buildSectionHeader('kebiasaan tidur'.tr, Icons.bedtime_outlined),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'kesulitan tidur'.tr,
            hint: 'pilih frekuensi'.tr,
            value: _sleepDifficulty,
            items:  [
              'tidak pernah'.tr,
              'jarang'.tr,
              'kadang-kadang'.tr,
              'sering'.tr,
              'selalu'.tr
            ],
            onChanged: (val) => setState(() => _sleepDifficulty = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'lama tidur (jam)'.tr,
            hint: 'pilih lama tidur'.tr,
            value: _sleepHours,
            items:  [
              'lebih dari 8 jam'.tr,
              '7-8 jam'.tr,
              '6-7 jam'.tr,
              '5-6 jam'.tr,
              '4-5 jam'.tr,
              'kurang dari 4 jam'.tr,
              'Kurang dari 5 jam'.tr
            ],
            onChanged: (val) => setState(() => _sleepHours = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'terbangun di malam hari'.tr,
            hint: 'pilih frekuensi'.tr,
            value: _nightWake,
            items: [
              'tidak Pernah'.tr,
              'jarang'.tr,
              'kadang-kadang'.tr,
              'sering'.tr,
              'selalu'.tr
            ],
            onChanged: (val) => setState(() => _nightWake = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'kualitas tidur'.tr,
            hint: 'pilih kualitas tidur'.tr,
            value: _sleepQuality,
            items:  [
              'sangat baik'.tr,
              'baik'.tr,
              'cukup'.tr,
              'buruk'.tr,
              'sangat buruk'.tr
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
          _buildSectionHeader('kondisi mental'.tr, Icons.psychology_outlined),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'kesulitan konsentrasi'.tr,
            hint: 'pilih frekuensi'.tr,
            value: _concentration,
            items: [
              'tidak pernah'.tr,
              'jarang'.tr,
              'kadang-kadang'.tr,
              'sering'.tr,
              'selalu'.tr
            ],
            onChanged: (val) => setState(() => _concentration = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'kelelahan'.tr,
            hint: 'pilih frekuensi'.tr,
            value: _fatigue,
            items:  [
              'tidak Pernah'.tr,
              'jarang'.tr,
              'kadang-kadang'.tr,
              'sering'.tr,
              'selalu'.tr
            ],
            onChanged: (val) => setState(() => _fatigue = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Ketidak hadiran kuliah'.tr,
            hint: 'pilih frekuensi'.tr,
            value: _missClass,
            items:  [
              'tidak pernah'.tr,
              'jarang(1-2 kali/bulan)'.tr,
              'kadang-kadang'.tr,
              'sering'.tr,
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
            title: 'tingkat stres'.tr,
            hint: 'pilih tingkat stres'.tr,
            value: _stress,
            items:  [
              'tidak stress'.tr,
              'stress rendah'.tr,
              'stress sedang'.tr,
              'stress tinggi'.tr,
              'sangat tinggi'.tr,
              'esktrem'
            ],
            onChanged: (val) => setState(() => _stress = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'performa akademik'.tr,
            hint: 'pilih performa'.tr,
            value: _performance,
            items:  [
              'sangat baik'.tr,
              'baik'.tr,
              'cukup'.tr,
              'dibawah rata-rata'.tr,
              'buruk'.tr
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
            label:  Text('sebelumnya'.tr),
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
           SizedBox.shrink(),
        ElevatedButton.icon(
          onPressed: _nextPage,
          label: Text(isLastPage ? 'klasifikasi'.tr : 'lanjut'.tr),
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
