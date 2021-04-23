library weather_repository;

import 'package:meta/meta.dart';
import 'package:metaweather_api/metaweather_api.dart';
import 'package:weather_repository/src/exceptions.dart';
import 'package:weather_repository/src/models/location.dart';
import 'package:weather_repository/src/models/models.dart';

class WeatherRepository {
  final MetaWeatherApiClient _metaWeatherApiClient;

  WeatherRepository({MetaWeatherApiClient metaWeatherApiClient})
      : _metaWeatherApiClient = metaWeatherApiClient ?? MetaWeatherApiClient();

  Future<List<Location>> searchForLocation({@required String term}) async {
    try {
      final locations = await _metaWeatherApiClient.searchForLocation(term);

      return locations.locations
              ?.map((e) => Location(e.woeid, e.title))
              ?.toList() ??
          [];
    } catch (e) {
      throw SearchForLocationException();
    }
  }

  Future<Forecast> forecastForLocation(int locationId) async {
    try {
      final response =
          await _metaWeatherApiClient.forecastForLocation(locationId);

      final forecast = Forecast(
        response.title,
        response.consolidatedWeather
            .map(
              (weatherData) => Weather(
                DateTime.parse(weatherData.applicableDate),
                weatherData.theTemp,
                weatherData.maxTemp,
                weatherData.minTemp,
                weatherData.weatherStateName,
                weatherData.weatherStateAbbr,
              ),
            )
            .toList(),
      );

      return forecast;
    } catch (e) {
      throw ForecastForLocationException();
    }
  }
}
