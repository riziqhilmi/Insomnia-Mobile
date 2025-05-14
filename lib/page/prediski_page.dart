import 'package:flutter/material.dart';


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
  double _sleepHours = 7.0;
  String? _concentrationDifficulty;
  String? _missClass;
  String? _deviceUse;
  String? _caffeine;
  String? _exercise;
  String? _stressLevel;
  String? _academicPerformance;
  // We don't include insomnia_level as it will be calculated

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_pageController.page!.toInt() < 2) {
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

  void _processClassification() {
    // Here you would implement your classification algorithm
    // For now we'll just show a dialog with a success message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2746),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Klasifikasi Berhasil',
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
              ),
              child: const Text(
                'Data telah diproses. Hasil klasifikasi: Risiko Insomnia',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
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
              'Tahun Keempat'
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
          const SizedBox(height: 16),
          _buildSliderField(
            title: 'Lama Tidur (jam)',
            value: _sleepHours,
            min: 4,
            max: 10,
            divisions: 12,
            onChanged: (val) => setState(() => _sleepHours = val),
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
          _buildSectionHeader('Kebiasaan Tidur', Icons.nightlight_round),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Penggunaan Perangkat Sebelum Tidur',
            hint: 'Pilih frekuensi',
            value: _deviceUse,
            items: const ['Tidak Pernah', 'Selalu'],
            onChanged: (val) => setState(() => _deviceUse = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Konsumsi Kafein',
            hint: 'Pilih jawaban',
            value: _caffeine,
            items: const ['Ya', 'Tidak'],
            onChanged: (val) => setState(() => _caffeine = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Aktivitas Olahraga',
            hint: 'Pilih jawaban',
            value: _exercise,
            items: const ['Ya', 'Tidak'],
            onChanged: (val) => setState(() => _exercise = val),
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
            value: _concentrationDifficulty,
            items: const ['Tidak Pernah', 'Kadang-kadang', 'Sering', 'Selalu'],
            onChanged: (val) => setState(() => _concentrationDifficulty = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Ketidakhadiran Kuliah',
            hint: 'Pilih frekuensi',
            value: _missClass,
            items: const ['Tidak Pernah', 'Kadang-kadang', 'Sering'],
            onChanged: (val) => setState(() => _missClass = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Tingkat Stres',
            hint: 'Pilih tingkat stres',
            value: _stressLevel,
            items: const ['Rendah', 'Sedang', 'Tinggi', 'Sangat Tinggi'],
            onChanged: (val) => setState(() => _stressLevel = val),
          ),
          const SizedBox(height: 16),
          _buildDropdownField(
            title: 'Performa Akademik',
            hint: 'Pilih performa',
            value: _academicPerformance,
            items: const ['Buruk', 'Cukup', 'Baik'],
            onChanged: (val) => setState(() => _academicPerformance = val),
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

  Widget _buildSliderField({
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required Function(double) onChanged,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.deepPurple,
              inactiveTrackColor: Colors.deepPurple.withOpacity(0.2),
              thumbColor: Colors.white,
              overlayColor: Colors.deepPurple.withOpacity(0.2),
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                min.toString(),
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 12),
              ),
              Text(
                max.toString(),
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 12),
              ),
            ],
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
          icon: Icon(isLastPage ? Icons.check_circle : Icons.arrow_forward_ios,
              size: 16),
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