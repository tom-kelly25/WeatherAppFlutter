import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  String _backgroundImage = 'assets/images/sunny.png';
  String _weatherIcon = 'assets/icons/sun.svg';

  Future<void> _getWeatherData() async {
    final city = _cityController.text.trim();
    if (city.isNotEmpty) {
      final weather = await WeatherApi.getCurrentWeather(city);
      setState(() {
        _weather = weather;
        // Set the background image and weather icon based on the weather description
        if (_weather!.description.toLowerCase().contains('clear')) {
          _backgroundImage = 'assets/images/sunny.png';
          _weatherIcon = 'assets/images/sun.svg';
        } else if (_weather!.description.toLowerCase().contains('clouds')) {
          _backgroundImage = 'assets/images/cloudy.png';
          _weatherIcon = 'assets/images/cloudy.svg';
        } else if (_weather!.description.toLowerCase().contains('rain')) {
          _backgroundImage = 'assets/images/rainy.png';
          _weatherIcon = 'assets/images/rain.svg';
        }
      });
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
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
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hoverColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.white),
                  counterStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _getWeatherData,
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                ),
                child: Text('Get Weather'),
              ),
              SizedBox(height: 32.0),
              if (_weather != null) ...[
                Text(
                  _weather!.city,
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0),
                SvgPicture.asset(
                  _weatherIcon,
                  height: 100.0,
                  width: 100.0,
                  color: Colors.white,
                ),
                SizedBox(height: 16.0),
                Text(
                  '${_weather!.temperature.toStringAsFixed(1)}°C',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                SizedBox(height: 16.0),
                Text(
                  _weather!.description,
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Last updated: ${DateFormat('dd/MM/yyyy').add_jm().format(DateTime.now())}',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  final String icon;

  const _WeatherIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    final double size = 64;
    switch (icon) {
      case 'sun':
        return SvgPicture.asset(
          'assets/icons/sun.svg',
          height: size,
          width: size,
        );
      case 'cloudy':
        return SvgPicture.asset(
          'assets/icons/cloudy.svg',
          height: size,
          width: size,
        );
      case 'rain':
        return SvgPicture.asset(
          'assets/icons/rain.svg',
          height: size,
          width: size,
        );
      default:
        return Container();
    }
  }
}
