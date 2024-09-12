// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WeatherModel {
  String name;
  DateTime localTime;
  double averageTempC;
  double minTempC;
  double maxTempC;
  String weatherStateName;
  //default constractor
  WeatherModel({
    required this.name,
    required this.localTime,
    required this.averageTempC,
    required this.minTempC,
    required this.maxTempC,
    required this.weatherStateName,
  });
  // factory named constractor
  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data["forecast"]["forecastday"][0]["day"];
    return WeatherModel(
        localTime: DateTime.parse(data["location"]["localtime"]),
        averageTempC: jsonData["avgtemp_c"],
        minTempC: jsonData["mintemp_c"],
        maxTempC: jsonData["maxtemp_c"],
        weatherStateName: jsonData["condition"]["text"],
        name: data["location"]["name"]);
  }
  @override
  String toString() {
    return "name: ($name) LocalTime is: ($localTime) AverageTempC is: ($averageTempC) MinTempC is: ($minTempC) MaxTempC is:($maxTempC) weatherState is: ($weatherStateName)";
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
