import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherApi {
  static const String _baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = '9f991a60ee5b9a258d4f97e732b8ebc3';

  static Future<Weather> getCurrentWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$_baseUrl?q=$cityName&appid=$_apiKey&units=metric'));
    final jsonBody = json.decode(response.body);
    final weather = Weather(
      city: jsonBody['name'],
      description: jsonBody['weather'][0]['description'],
      temperature: jsonBody['main']['temp'],
    );
    return weather;
  }
}
