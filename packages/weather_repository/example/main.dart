import 'dart:io';

import 'package:weather_repository/src/weather_repository.dart';

void main() async {
  final repository = WeatherRepository();

  try {
    final locations = await repository.searchForLocation(term: 'New York');
    if (locations.length == 0) {
      print('No Location Found');
      return;
    }
    final location = locations.first;
    print('${location.name}');

    final forecast =
        await repository.forecastForLocation(locationId: location.id);
    if (forecast.weather.length == 0) {
      print('No Weather Forecast Found');
      return;
    }
    final currentTemp = forecast.weather.first.temp;
    print('current temp: $currentTemp');
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}
