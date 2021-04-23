import 'package:weather_repository/src/models/weather.dart';

class Forecast {
  final String locationName;
  final List<Weather> weather;

  Forecast(this.locationName, this.weather);
}
