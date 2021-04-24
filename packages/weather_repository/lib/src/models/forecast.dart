import 'package:equatable/equatable.dart';
import 'package:weather_repository/src/models/weather.dart';

class Forecast extends Equatable {
  final String locationName;
  final int locationId;
  final List<Weather> weather;

  const Forecast({
    required this.locationName,
    required this.weather,
    required this.locationId,
  });

  @override
  List<Object?> get props => [locationName, weather, locationId];
}
