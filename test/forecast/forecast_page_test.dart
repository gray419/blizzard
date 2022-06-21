import 'package:blizzard/forecast/view/forecast_page.dart';
import 'package:blizzard/forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('ForecastPage', () {
    late WeatherRepository weatherRepository;
    final locationId = 1;
    final forecast = Forecast(
      locationName: 'Nyc',
      locationId: 1,
      weather: [
        Weather(DateTime.now(), 10, 10, 10, 'Cloudy', 'C'),
        Weather(DateTime.now(), 10, 10, 10, 'Cloudy', 'C'),
      ],
    );

    setUp(() {
      weatherRepository = MockWeatherRepository();
      when(() => weatherRepository.forecastForLocation(locationId: locationId))
          .thenAnswer((_) => Future.value(forecast));
    });

    testWidgets('renders ForecastPage', (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(RepositoryProvider.value(
          value: weatherRepository,
          child: MaterialApp(
            home: ForecastPage(
              locationId: 1,
            ),
          ),
        ));
        await tester.pumpAndSettle();
        expect(find.byType(ForecastFrame), findsOneWidget);
        expect(find.byType(TodaysWeather), findsOneWidget);
        expect(find.byType(ForecastResults), findsOneWidget);
        expect(find.byType(TemperatureUnits), findsOneWidget);
        expect(find.byType(ListTile), findsOneWidget);
      });
    });

    group('errors', () {
      setUp(() {
        weatherRepository = MockWeatherRepository();
        when(() => weatherRepository.forecastForLocation(locationId: locationId)).thenThrow((_) => Exception('error'));
      });

      testWidgets('renders ForecastPage error view', (tester) async {
        mockNetworkImagesFor(() async {
          await tester.pumpWidget(RepositoryProvider.value(
            value: weatherRepository,
            child: MaterialApp(
              home: ForecastPage(
                locationId: 1,
              ),
            ),
          ));
          await tester.pumpAndSettle();
          expect(find.byType(ForecastFrame), findsOneWidget);
          expect(find.text('Error fetching the forecast'), findsOneWidget);
        });
      });
    });
  });
}
