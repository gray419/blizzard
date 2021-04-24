import 'package:metaweather_api/metaweather_api.dart';
import 'package:metaweather_api/models/location_response.dart';
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
      (_) async => LocationResponse(
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
}
