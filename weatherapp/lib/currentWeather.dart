import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';

class CurrentWeather extends StatefulWidget {
  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Weather App")),
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
