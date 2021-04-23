library metaweather_api;

import 'package:metaweather_api/models/forecast_response.dart';
import 'package:metaweather_api/models/location_response.dart';

abstract class WeatherService {
  Future<LocationResponse> searchForLocation(String term);
  Future<ForecastResponse> forecastForLocation(String locationId);
}
