import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Météo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _cityController = TextEditingController();
  Map<String, dynamic> _weatherData = {};

  Future<void> _fetchWeather() async {
    try {
      final data = await _apiService.getWeather(_cityController.text);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Entrez une ville',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Voir la météo'),
            ),
            SizedBox(height: 20),
            if (_weatherData.isNotEmpty)
              Column(
                children: [
                  Text(
                    'Météo à ${_weatherData['name']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_weatherData['main']['temp']}°C',
                    style: TextStyle(fontSize: 48),
                  ),
                  Text(
                    '${_weatherData['weather'][0]['description']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
