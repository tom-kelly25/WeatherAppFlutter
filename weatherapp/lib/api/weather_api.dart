import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherApi {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = '';

  static Future<Weather> getCurrentWeather(String city) async {
    final response = await http
        .get(Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'));
    final jsonData = json.decode(response.body);

    final weather = Weather(
      city: jsonData['name'],
      description: jsonData['weather'][0]['description'],
      temperature: jsonData['main']['temp'],
    );

    return weather;
  }
}
