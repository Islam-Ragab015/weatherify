import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherify/models/weather_model.dart';
import 'package:weatherify/moduls/home_page/home_page.dart';
import 'package:weatherify/moduls/services/weather_services.dart';
import 'package:weatherify/providers/weather_provider.dart';

class WeatherSearchScreen extends StatelessWidget {
  VoidCallback? updatingUi;
  WeatherSearchScreen({
    super.key,
    this.updatingUi,
  });
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blueAccent[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent[100]!, Colors.blueAccent[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search input field
            TextField(
              onChanged: (value) => cityName = value,
              onSubmitted: (value) async {
                cityName = value;
                await _searchWeather(context);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.8),
                hintText: 'Enter a location',
                hintStyle: TextStyle(color: Colors.blueGrey[300]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.blueAccent),
                  onPressed: () async {
                    await _searchWeather(context);
                  },
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchWeather(BuildContext context) async {
    WeatherServices weatherServices = WeatherServices();
    WeatherModel? weather = await weatherServices.getweather(
      theCityName: cityName!,
    );
    Provider.of<WeatherProvider>(context, listen: false).weatherData = weather;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(title: "Weatherify"),
      ),
    );
  }
}
