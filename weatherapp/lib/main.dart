import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/weather.dart';
import 'api/weather_api.dart';

import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _cityController = TextEditingController();
  Weather? _weather;

  Future<void> _getWeatherData() async {
    final city = _cityController.text.trim();
    if (city.isNotEmpty) {
      final weather = await WeatherApi.getCurrentWeather(city);
      setState(() {
        _weather = weather;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getWeatherData,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 16.0),
            if (_weather != null) ...[
              Text(
                _weather!.city,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '${_weather!.temperature.toStringAsFixed(1)}°C',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                _weather!.description,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Last updated: ${DateFormat.yMd().add_jm().format(DateTime.now())}',
                style: TextStyle(fontSize: 12.0),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
