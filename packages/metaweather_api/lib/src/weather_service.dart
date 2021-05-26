library metaweather_api;

import 'package:metaweather_api/models/forecast_response.dart';
import 'package:metaweather_api/models/location.dart';

abstract class WeatherService {
  Future<List<Location>> searchForLocation(String term);
  Future<ForecastResponse> forecastForLocation(int locationId);
}
