import 'dart:convert';
// to have access to all http componants
import 'package:http/http.dart' as http;
import 'package:weatherify/models/weather_model.dart';

/* 
    1- Uri.parse for url to convert the request from String into url object
    2- use the function get to get that url
    3- save the return of get funcion and is "Response" return type in variable "response" 
    4- don't forget that get function is "Future<Response>" so ---> async and await
    5- jsonDecode to convert the String of Respons into json style to easy have access to it's components and save the result in variable of Map
*/
class WeatherServices {
  Future<WeatherModel?> getweather({required String theCityName}) async {
    WeatherModel? weather;
    try {
      String baseUrl = "http://api.weatherapi.com/v1";
      String apiKey = "8b6b5c0306f5414c868140909230604";
      Uri url =
          Uri.parse("$baseUrl/forecast.json?key=$apiKey&q=$theCityName&days=5");
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);

      weather = WeatherModel.fromJson(data);
    // ignore: empty_catches
    } catch (e) {
    }

    return weather;
  }
}
