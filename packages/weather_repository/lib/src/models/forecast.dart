import 'package:equatable/equatable.dart';
import 'package:weather_repository/src/models/weather.dart';

class Forecast extends Equatable {
  final String locationName;
  final List<Weather> weather;

  const Forecast(this.locationName, this.weather);

  @override
  List<Object?> get props => [locationName, weather];
}
