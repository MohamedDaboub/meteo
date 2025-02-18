import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteo/models/api_service.dart';
import 'package:meteo/ui/city_weather_page.dart'; // Importez la page CityWeatherPage

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final ApiService _apiService = ApiService();
  final TextEditingController _cityController = TextEditingController();
  String _errorMessage = '';

  // Liste de villes prédéfinies
  final List<String> predefinedCities = [
    'Paris',
    'Lyon',
    'Marseille',
    'Bordeaux',
    'Toulouse',
    'Nice',
    'Nantes',
    'Strasbourg',
    'Montpellier',
    'Lille',
  ];

  void _searchWeather(String city) async {
    if (city.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer une ville';
      });
      return;
    }

    try {
      final weatherData = await _apiService.getWeather(city);
      // Rediriger vers la page CityWeatherPage avec les données météorologiques
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CityWeatherPage(weatherData: weatherData),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Impossible de récupérer les données météorologiques';
      });
    }
  }

  // Méthode pour détecter la localisation de l'utilisateur
  void _detectLocation() async {
    // Vérifier les permissions de localisation
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _errorMessage = 'Le service de localisation est désactivé';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _errorMessage = 'Les permissions de localisation sont refusées';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _errorMessage =
            'Les permissions de localisation sont refusées de manière permanente';
      });
      return;
    }

    // Obtenir la position actuelle
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      // Récupérer la météo en fonction des coordonnées GPS
      final weatherData = await _apiService.getWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );

      // Rediriger vers la page CityWeatherPage avec les données météorologiques
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CityWeatherPage(weatherData: weatherData),
        ),
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Impossible de détecter la localisation';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre
            Text(
              'Choisissez une ville prédéfinie ou recherchez une ville :',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),

            // Liste des villes prédéfinies
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: predefinedCities.map((city) {
                return ElevatedButton(
                  onPressed: () => _searchWeather(city),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.blue[900],
                  ),
                  child: Text(city),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Champ de recherche
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Rechercher une ville',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchWeather(_cityController.text.trim()),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Affichage des erreurs
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
      // Icône de détection de localisation en bas à droite
      floatingActionButton: FloatingActionButton(
        onPressed: _detectLocation,
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
