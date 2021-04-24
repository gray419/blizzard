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
      final forecast = Forecast(
        locationName: 'Nyc',
        locationId: 1,
        weather: [
          Weather(DateTime.now(), 10, 10, 10, 'Cloudy', 'C'),
        ],
      );
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
          ForecastState.loading(true),
          ForecastState.success(forecast, true),
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
          ForecastState.loading(true),
          ForecastState.failure()
        ],
      );
    });

    group('switch units', () {
      final locationId = 1;
      final date = DateTime.now();
      final forecast = Forecast(
        locationName: 'Nyc',
        locationId: 1,
        weather: [
          Weather(date, 10.0, 10.0, 10.0, 'Cloudy', 'C'),
        ],
      );
      final forecastFahrenheit = Forecast(
        locationName: 'Nyc',
        locationId: 1,
        weather: [
          Weather(date, 50.0, 50.0, 50.0, 'Cloudy', 'C'),
        ],
      );
      late WeatherRepository weatherRepository;

      setUp(() {
        weatherRepository = MockWeatherRepository();
        when(() => weatherRepository.forecastForLocation(locationId))
            .thenAnswer((_) => Future.value(forecast));
      });

      blocTest<ForecastCubit, ForecastState>(
        'emits ForecastState success',
        build: () => ForecastCubit(weatherRepository),
        seed: () => ForecastState.success(forecast, true),
        act: (cubit) => cubit.switchUnits(),
        expect: () => <ForecastState>[
          ForecastState.success(forecastFahrenheit, false),
        ],
      );
    });

    group('refresh', () {
      final locationId = 1;
      final date = DateTime.now();
      final forecast = Forecast(
        locationName: 'Nyc',
        locationId: 1,
        weather: [
          Weather(date, 10.0, 10.0, 10.0, 'Cloudy', 'C'),
        ],
      );
      late WeatherRepository weatherRepository;

      setUp(() {
        weatherRepository = MockWeatherRepository();
        when(() => weatherRepository.forecastForLocation(locationId))
            .thenAnswer((_) => Future.value(forecast));
      });

      blocTest<ForecastCubit, ForecastState>(
        'invoke searchForLocation on repository',
        build: () => ForecastCubit(weatherRepository),
        act: (cubit) => cubit.refreshForecast(locationId),
        verify: (_) => verify(
          () => weatherRepository.forecastForLocation(locationId),
        ).called(1),
      );

      blocTest<ForecastCubit, ForecastState>(
        'emits loading, success when refresh succeeds',
        build: () => ForecastCubit(weatherRepository),
        act: (cubit) => cubit.refreshForecast(locationId),
        expect: () => <ForecastState>[
          ForecastState.loading(true),
          ForecastState.success(forecast, true),
        ],
      );

      blocTest<ForecastCubit, ForecastState>(
        'emits loading, error when refresh erros',
        build: () {
          when(() => weatherRepository.forecastForLocation(locationId))
              .thenThrow((_) => Exception('Error'));
          return ForecastCubit(weatherRepository);
        },
        act: (cubit) => cubit.refreshForecast(locationId),
        expect: () => <ForecastState>[
          ForecastState.loading(true),
          ForecastState.failure(),
        ],
      );
    });
  });
}
