library weather_repository;

import 'package:metaweather_api/metaweather_api.dart';
import 'package:weather_repository/src/exceptions.dart';
import 'package:weather_repository/src/models/location.dart';
import 'package:weather_repository/src/models/models.dart';

class WeatherRepository {
  final MetaWeatherApiClient _metaWeatherApiClient;

  WeatherRepository({MetaWeatherApiClient? metaWeatherApiClient})
      : _metaWeatherApiClient = metaWeatherApiClient ?? MetaWeatherApiClient();

  Future<List<Location>> searchForLocation({required String term}) async {
    try {
      final locationResponse =
          await _metaWeatherApiClient.searchForLocation(term);

      var locations = <Location>[];

      locationResponse.locations?.forEach((element) {
        if (element.woeid != null && element.title != null) {
          locations.add(Location(element.woeid!, element.title!));
        }
      });

      return locations;
    } catch (e) {
      throw SearchForLocationException();
    }
  }

  Future<Forecast> forecastForLocation(int locationId) async {
    try {
      final response =
          await _metaWeatherApiClient.forecastForLocation(locationId);

      final List<Weather> weatherResponse = response.consolidatedWeather
              ?.map((weatherData) => Weather(
                    DateTime.parse(weatherData.applicableDate ?? ''),
                    weatherData.theTemp ?? 0.0,
                    weatherData.maxTemp ?? 0.0,
                    weatherData.minTemp ?? 0.0,
                    weatherData.weatherStateName ?? '',
                    weatherData.weatherStateAbbr ?? '',
                  ))
              .toList() ??
          [];

      final forecast = Forecast(
        response.title ?? '',
        weatherResponse,
      );

      return forecast;
    } catch (e) {
      throw ForecastForLocationException();
    }
  }
}
