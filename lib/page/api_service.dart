import 'dart:convert';
import 'package:http/http.dart' as http;
import 'prediction_request.dart';

class ApiService {
  static const String baseUrl =
      'http://127.0.0.1:5000'; // Ganti dengan IP server Flask

  static Future<Map<String, dynamic>> predictInsomnia(
      PredictionRequest request) async {
    final url = Uri.parse('$baseUrl/predict');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get prediction: ${response.statusCode}');
    }
  }
}
