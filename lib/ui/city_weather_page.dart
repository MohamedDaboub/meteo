import 'package:flutter/material.dart';

class CityWeatherPage extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const CityWeatherPage({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo à ${weatherData['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Météo à ${weatherData['name']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Température: ${weatherData['main']['temp']}°C',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Conditions: ${weatherData['weather'][0]['description']}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Humidité: ${weatherData['main']['humidity']}%',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Vent: ${weatherData['wind']['speed']} m/s',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
