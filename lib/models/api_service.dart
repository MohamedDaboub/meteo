import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = '';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeather(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric&lang=fr'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> getWeatherByCoordinates(
      double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric&lang=fr'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
