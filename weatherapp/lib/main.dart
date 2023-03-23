import 'package:flutter/material.dart';
import 'models/weather.dart';
import 'api/weather_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _getCurrentWeather();
  }

  Future<void> _getCurrentWeather() async {
    final weather = await WeatherApi.getCurrentWeather('New York');
    setState(() {
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _weather != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_weather!.description),
                    Text('${_weather!.temperature.toString()}°C'),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
