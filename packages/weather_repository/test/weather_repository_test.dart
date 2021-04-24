import 'package:metaweather_api/metaweather_api.dart';
import 'package:metaweather_api/models/models.dart' as metaweather;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_repository/src/models/models.dart';
import 'package:weather_repository/src/weather_repository.dart';

class MockWeatherService extends Mock implements WeatherService {}

void main() {
  final searchTerm = 'nyc';
  late WeatherService weatherService;
  late WeatherRepository weatherRepository;

  setUp(() {
    weatherService = MockWeatherService();
    when(() => weatherService.searchForLocation(searchTerm)).thenAnswer(
      (_) async => metaweather.LocationResponse(
        locations: [
          metaweather.Location(title: 'New York', woeid: 1),
        ],
      ),
    );
    weatherRepository = WeatherRepository(weatherService: weatherService);
  });

  test('searchForLocation success', () async {
    final locations =
        await weatherRepository.searchForLocation(term: searchTerm);
    final location = locations.first;
    expect(location, Location(1, 'New York'));
  });

  test('calls searchForLocation with city', () async {
    try {
      await weatherRepository.searchForLocation(term: searchTerm);
    } catch (_) {}
    verify(() => weatherService.searchForLocation(searchTerm)).called(1);
  });

  group('forecast', () {
    late WeatherService weatherService;
    late WeatherRepository weatherRepository;
    final locationId = 1;
    final date = DateTime.now();

    setUp(() {
      weatherService = MockWeatherService();
      when(() => weatherService.forecastForLocation(locationId)).thenAnswer(
        (_) async => metaweather.ForecastResponse(
          title: 'nyc',
          woeid: 1,
          consolidatedWeather: [
            metaweather.ConsolidatedWeather(
                applicableDate: date.toString(),
                theTemp: 1,
                minTemp: 1,
                maxTemp: 1,
                weatherStateName: 'cloudy',
                weatherStateAbbr: 'c'),
          ],
        ),
      );
      weatherRepository = WeatherRepository(weatherService: weatherService);
    });

    test('calls forecastForLocation success', () async {
      final forecast =
          await weatherRepository.forecastForLocation(locationId: locationId);
      expect(
        forecast,
        Forecast(
            locationName: 'nyc',
            weather: [Weather(date, 1, 1, 1, 'cloudy', 'c')],
            locationId: 1),
      );
    });

    test('calls forecastForLocation with locationId', () async {
      try {
        await weatherRepository.forecastForLocation(locationId: locationId);
      } catch (_) {}
      verify(() => weatherService.forecastForLocation(locationId)).called(1);
    });
  });
}
