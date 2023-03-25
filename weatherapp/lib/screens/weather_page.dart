import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../api/weather_api.dart';
import '../models/weather.dart';

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sunny.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter city name',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hoverColor: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _getWeatherData,
                child: Text('Get Weather'),
              ),
              SizedBox(height: 32.0),
              if (_weather != null) ...[
                Text(
                  _weather!.city,
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '${_weather!.temperature.toStringAsFixed(1)}°C',
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  _weather!.description,
                  style: TextStyle(fontSize: 24.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Last updated: ${DateFormat('dd/MM/yyyy').add_jm().format(DateTime.now())}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
