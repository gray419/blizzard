library weather_repository;

import 'package:metaweather_api/metaweather_api.dart';
import 'package:weather_repository/src/exceptions.dart';
import 'package:weather_repository/src/models/location.dart';
import 'package:weather_repository/src/models/models.dart';

class WeatherRepository {
  final WeatherService _metaWeatherService;

  WeatherRepository({WeatherService? weatherService})
      : _metaWeatherService = weatherService ?? MetaWeatherApiClient();

  Future<List<Location>> searchForLocation({required String term}) async {
    try {
      final locationResponse =
          await _metaWeatherService.searchForLocation(term);

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
          await _metaWeatherService.forecastForLocation(locationId);

      final List<Weather> weatherResponse = response.consolidatedWeather
              ?.map((weatherData) => Weather(
                    DateTime.parse(weatherData.applicableDate ?? ''),
                    weatherData.theTemp?.round() ?? 0,
                    weatherData.maxTemp?.round() ?? 0,
                    weatherData.minTemp?.round() ?? 0,
                    weatherData.weatherStateName ?? '',
                    weatherData.weatherStateAbbr ?? '',
                  ))
              .toList() ??
          [];

      return Forecast(response.title ?? '', weatherResponse);
    } catch (e) {
      throw ForecastForLocationException();
    }
  }
}
