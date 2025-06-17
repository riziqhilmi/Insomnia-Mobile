import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:insomnia_app/utils/base-url.dart';
import 'prediction_request.dart';

class ApiService {
  // Ganti dengan IP server Flask

  static Future<Map<String, dynamic>> predictInsomnia(
      PredictionRequest request) async {
     var uri = Uri.parse('$url/predict');
    final response = await http.post(
      uri,
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
