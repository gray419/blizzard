import 'package:blizzard/forecast/bloc/forecast_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('ForecastCubit', () {
    test('initial state is Forecast.initial', () {
      final weatherRepository = MockWeatherRepository();
      final forecastCubit = ForecastCubit(weatherRepository);
      expect(forecastCubit.state, const ForecastState.initial());
      forecastCubit.close();
    });

    group('search for location', () {
      final locationId = 1;
      final forecast = Forecast('Nyc', [
        Weather(DateTime.now(), 10, 10, 10, 'Cloudy', 'C'),
      ]);
      late WeatherRepository weatherRepository;

      setUp(() {
        weatherRepository = MockWeatherRepository();
        when(() => weatherRepository.forecastForLocation(locationId))
            .thenAnswer((_) => Future.value(forecast));
      });

      blocTest<ForecastCubit, ForecastState>(
        'invoke searchForLocation on repository',
        build: () => ForecastCubit(weatherRepository),
        act: (cubit) => cubit.fetchForecast(locationId),
        verify: (_) => verify(
          () => weatherRepository.forecastForLocation(locationId),
        ).called(1),
      );

      blocTest<ForecastCubit, ForecastState>(
        'emits loading, success when searchForLocation succeeds',
        build: () => ForecastCubit(weatherRepository),
        act: (cubit) => cubit.fetchForecast(locationId),
        expect: () => <ForecastState>[
          ForecastState.loading(),
          ForecastState.success(forecast),
        ],
      );

      blocTest<ForecastCubit, ForecastState>(
        'emits loading, error when searchForLocation throws',
        build: () {
          when(() => weatherRepository.forecastForLocation(locationId))
              .thenThrow((_) => Exception('Error'));
          return ForecastCubit(weatherRepository);
        },
        act: (cubit) => cubit.fetchForecast(locationId),
        expect: () => const <ForecastState>[
          ForecastState.loading(),
          ForecastState.failure()
        ],
      );
    });
  });
}
