import 'package:blizzard/search/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('SearchPage', () {
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherRepository = MockWeatherRepository();
    });

    testWidgets('renders SearchPage', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: weatherRepository,
        child: MaterialApp(
          home: SearchPage(),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(SearchForm), findsOneWidget);
    });
  });
}
