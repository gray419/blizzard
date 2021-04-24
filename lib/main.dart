import 'package:blizzard/blizzard.dart';
import 'package:flutter/material.dart';
import 'package:weather_repository/weather_repository.dart';

void main() {
  runApp(BlizzardApp(
    weatherRepository: WeatherRepository(),
  ));
}
