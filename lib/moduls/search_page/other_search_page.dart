// ignore_for_file: must_be_immutable, use_build_context_synchronously

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
        title: const Text('Search Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search input field
            TextField(
              onChanged: (value) {
                cityName = value;
              },
              onSubmitted: (value) async {
                cityName = value;
                WeatherServices weatherServices = WeatherServices();
                WeatherModel? weather =
                    await weatherServices.getweather(theCityName: cityName!);
                Provider.of<WeatherProvider>(context, listen: false)
                    .weatherData = weather;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(title: "Weatherify"),
                    ));
              },
              decoration: InputDecoration(
                hintText: 'Enter a location',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    WeatherServices weatherServices = WeatherServices();
                    WeatherModel? weather = await weatherServices.getweather(
                        theCityName: cityName!);
                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherData = weather;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(title: "Weatherify"),
                        ));
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 8),
            // List of recent searches
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const ListTile(
                      // title: Text('Recent Search ${index + 1}'),
                      // trailing: const Icon(Icons.arrow_forward),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
