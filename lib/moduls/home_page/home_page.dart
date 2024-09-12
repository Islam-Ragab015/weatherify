
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherify/models/weather_model.dart';
import 'package:weatherify/moduls/search_page/search_page.dart';
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
                      builder: (context) => Search(
                        updatingUi: updateUi,
                      ),
                    ));
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ))
        ],
        title: const Text("Weatherify"),
      ),
      body: weatherData == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "There is no weather 😴 Strat",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Searching now 🔎",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  weatherData!.getThemeColor(),
                  weatherData!.getThemeColor()[300]!,
                  weatherData!.getThemeColor()[200]!,
                  // weatherData!.getThemeColor()[100]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weatherData!.name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Updated at:  ${weatherData!.localTime.hour}:${weatherData!.localTime.minute}",
                    style: const TextStyle(fontSize: 21),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        weatherData!.getImage(),
                        fit: BoxFit.cover,
                        scale: 0.35,
                      ),
                      Text(
                        "${weatherData!.averageTempC.toInt()}",
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: [
                          Text(
                            "Max : ${weatherData!.maxTempC.toInt()}",
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            "Min : ${weatherData!.minTempC.toInt()}",
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //statue
                  Text(
                    weatherData!.weatherStateName,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
    );
  }
}
