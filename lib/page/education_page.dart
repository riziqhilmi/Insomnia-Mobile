import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:insomnia_app/utils/base-url.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edukasi Tidur',
      theme: ThemeData(
        primaryColor: Color(0xFF1E2746),
        brightness: Brightness.dark,
      ),
      home: EducationPage(),
    );
  }
}

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  late Future<List<Map<String, dynamic>>> futureEducation;

  @override
  void initState() {
    super.initState();
    futureEducation = fetchEducation();
  }

  Future<List<Map<String, dynamic>>> fetchEducation() async {
    final response = await http.get(Uri.parse('$url/education'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData['data']);
    } else {
      throw Exception('Failed to load education data');
    }
  }

  void showEducationDetail(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        content: Text(content, style: TextStyle(color: Colors.white70)),
        backgroundColor: Color(0xFF1E2746),
        actions: [
          TextButton(
            child: Text("Tutup", style: TextStyle(color: Colors.blueAccent)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edukasi Tidur'),
        backgroundColor: Color(0xFF1E2746),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureEducation,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          }
          final edukasiList = snapshot.data!;

          return ListView.builder(
            itemCount: edukasiList.length,
            itemBuilder: (context, index) {
              final item = edukasiList[index];
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3A3D5C), Color(0xFF1E2746)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text(
                      item['judul'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      item['konten'].split('.').first + '...',
                      style: TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      showEducationDetail(context, item['judul'], item['konten']);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}