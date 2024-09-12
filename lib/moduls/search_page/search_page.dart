// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// ignore_for_file: avoid_print, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherify/models/weather_model.dart';
import 'package:weatherify/moduls/services/weather_services.dart';
import 'package:weatherify/providers/weather_provider.dart';

class Search extends StatelessWidget {
  VoidCallback? updatingUi;
  Search({
    this.updatingUi,
  });
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search for a City"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
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

                Navigator.pop(context);
              },
              decoration: InputDecoration(
                  hintText: "Enter a City",
                  border: const OutlineInputBorder(),
                  label: const Text("Search"),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  prefixIcon: GestureDetector(
                    child: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                    onTap: () async {
                      WeatherServices weatherServices = WeatherServices();
                      WeatherModel? weather = await weatherServices.getweather(
                          theCityName: cityName!);
                      Provider.of<WeatherProvider>(context, listen: false)
                          .weatherData = weather;
                      Navigator.pop(context);
                    },
                  ),
                  suffix: TextButton(
                      onPressed: () async {
                        WeatherServices weatherServices = WeatherServices();
                        WeatherModel? weather = await weatherServices
                            .getweather(theCityName: cityName!);
                        Provider.of<WeatherProvider>(context, listen: false)
                            .weatherData = weather;
                        Navigator.pop(context);
                      },
                      child: const Text("Search"))),
            ),
          ),
        ));
  }
}
