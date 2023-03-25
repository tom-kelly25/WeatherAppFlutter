import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'api/weather_api.dart';
import 'models/weather.dart';
import 'screens/weather_page.dart';

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
