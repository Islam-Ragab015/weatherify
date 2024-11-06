import 'package:flutter/material.dart';

class WeatherModel {
  String name;
  DateTime localTime;
  double averageTempC;
  double minTempC;
  double maxTempC;
  String weatherStateName;
  double feelsLikeTempC;
  double windSpeed; // Added windSpeed field
  int humidity; // Added humidity field

  // Default constructor
  WeatherModel({
    required this.name,
    required this.localTime,
    required this.averageTempC,
    required this.minTempC,
    required this.maxTempC,
    required this.weatherStateName,
    required this.feelsLikeTempC,
    required this.windSpeed, // Initialize windSpeed
    required this.humidity, // Initialize humidity
  });

  // Factory constructor to parse the response from the API
  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data["forecast"]["forecastday"][0]["day"];
    return WeatherModel(
      localTime: DateTime.parse(data["location"]["localtime"]),
      averageTempC: jsonData["avgtemp_c"],
      minTempC: jsonData["mintemp_c"],
      maxTempC: jsonData["maxtemp_c"],
      weatherStateName: jsonData["condition"]["text"],
      name: data["location"]["name"],
      feelsLikeTempC: data["current"]["feelslike_c"],
      windSpeed: data["current"]["wind_kph"], // Parse wind speed (in km/h)
      humidity: data["current"]["humidity"], // Parse humidity
    );
  }

  @override
  String toString() {
    return "name: ($name) LocalTime is: ($localTime) AverageTempC is: ($averageTempC) MinTempC is: ($minTempC) MaxTempC is:($maxTempC) weatherState is: ($weatherStateName) feelsLikeTempC is: ($feelsLikeTempC) windSpeed is: ($windSpeed) humidity is: ($humidity)";
  }

  String getImage() {
    if (weatherStateName == 'Clear' || weatherStateName == 'Sunny') {
      return "assets/images/clear.png";
    } else if (weatherStateName == "Heavy Cloud" ||
        weatherStateName == 'Light Cloud' ||
        weatherStateName == "Partly Cloudy") {
      return "assets/images/cloudy.png";
    } else if (weatherStateName == "Heavy Rain" ||
        weatherStateName == "Light Rain" ||
        weatherStateName == "Showers") {
      return "assets/images/rainy.png";
    } else if (weatherStateName == "Thunderstorm" ||
        weatherStateName == "Thunder") {
      return "assets/images/Thunderstorm.png";
    } else if (weatherStateName == "Snow" ||
        weatherStateName == "Sleet" ||
        weatherStateName == "Hail") {
      return "assets/images/snow.png";
    } else {
      return "assets/images/clear.png";
    }
  }

  MaterialColor getThemeColor() {
    if (weatherStateName == 'Clear' ||
        weatherStateName == 'Light Cloud' ||
        weatherStateName == 'Sunny') {
      return Colors.orange;
    } else if (weatherStateName == "Heavy Cloud") {
      return Colors.brown;
    } else if (weatherStateName == "Heavy Rain" ||
        weatherStateName == "Light Rain" ||
        weatherStateName == "Showers") {
      return Colors.amber;
    } else if (weatherStateName == "Thunderstorm" ||
        weatherStateName == "Thunder") {
      return Colors.grey;
    } else if (weatherStateName == "Snow" ||
        weatherStateName == "Sleet" ||
        weatherStateName == "Hail") {
      return Colors.blueGrey;
    } else {
      return Colors.blue;
    }
  }
}
