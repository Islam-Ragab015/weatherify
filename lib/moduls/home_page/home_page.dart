import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherify/models/weather_model.dart';
import 'package:weatherify/moduls/search_page/other_search_page.dart';
import 'package:weatherify/providers/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateUi() {
    setState(() {});
  }

  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WeatherSearchScreen(
                    updatingUi: updateUi,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          )
        ],
        title: const Text("Weatherify"),
        backgroundColor: Colors.blueAccent[700],
      ),
      body: weatherData == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "There is no weather 😴 Start searching now 🔎",
                    style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    weatherData!.getThemeColor(),
                    weatherData!.getThemeColor()[300]! as Color,
                    weatherData!.getThemeColor()[200]! as Color,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weatherData!.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Updated at: ${weatherData!.localTime.hour}:${weatherData!.localTime.minute}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Main Weather Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          weatherData!.getImage(),
                          fit: BoxFit.cover,
                          scale: 0.35,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${weatherData!.averageTempC.toInt()}°C",
                              style: const TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              weatherData!.weatherStateName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Additional Weather Information (Humidity, Wind Speed)
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Colors.white.withOpacity(0.85),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            _buildWeatherInfoRow(
                              label: "Humidity:",
                              value: "${weatherData!.humidity}%",
                            ),
                            _buildWeatherInfoRow(
                              label: "Wind Speed:",
                              value: "${weatherData!.windSpeed} km/h",
                            ),
                            _buildWeatherInfoRow(
                              label: "Feels Like:",
                              value: "${weatherData!.feelsLikeTempC.toInt()}°C",
                            ),
                            _buildWeatherInfoRow(
                              label: "Sunrise:",
                              value:
                                  "${weatherData!.localTime.hour}:${weatherData!.localTime.minute}",
                            ),
                            _buildWeatherInfoRow(
                              label: "Sunset:",
                              value:
                                  "${weatherData!.localTime.hour + 12}:${weatherData!.localTime.minute}",
                            ),
                            const SizedBox(height: 10),
                            // Air Quality (Example Placeholder)
                            _buildWeatherInfoRow(
                              label: "Air Quality:",
                              value:
                                  "Good", // Replace with actual air quality data
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Bottom Section for Max and Min Temps
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildTempColumn("Max Temp", weatherData!.maxTempC),
                        _buildTempColumn("Min Temp", weatherData!.minTempC),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // Helper method to create each row in the weather info card
  Widget _buildWeatherInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for creating max/min temp sections
  Widget _buildTempColumn(String label, double temp) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
        Text(
          "${temp.toInt()}°C",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
