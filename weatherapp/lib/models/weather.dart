class Weather {
  final double temp;
  final double feelslike;
  final double low;
  final double high;
  final String description;

  Weather({this.temp, this.feelslike, this.high, this.description, this.low});

  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
      return Weather(
        temp: json['main']['temp'].toDouble(),
        feelslike: json['main']['feelslike'].toDouble(),
        low: json['main']['temp_min'].toDouble(),
        high: json['main']['temp_max'].toDouble(),
        description: json['weather'][0]['description'],
      );
    } catch (e) {
      print('Error parsing weather data: $e');
      return null;
    }
  }
}
