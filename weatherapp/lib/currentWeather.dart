import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:http/http.dart' as http;

class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Weather _weather = snapshot.data;
            if (_weather == null) {
              return Text("Error getting weather");
            } else {
              return weatherBox(_weather);
            }
          } else {
            return CircularProgressIndicator();
          }
        },
        future: getCurrentWeather(),
      )),
    );
  }
}

Widget weatherBox(Weather _weather) {
  return Column(
    children: <Widget>[
      Text("${_weather.temp}°C"),
      Text("${_weather.description}°C"),
      Text("${_weather.feelslike}°C"),
      Text("H ${_weather.high}°C L:${_weather.low}"),
    ],
  );
}

Future getCurrentWeather() async {
  Weather weather;
  String city = "crewe";
  String apiKey = "206e59a88ba0a8f51d9cce62450d6f4c";
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

  final response = await http.get(url);
}
