import 'package:blizzard/search/view/search_page.dart';
import 'package:blizzard/search/widgets/search_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('SearchPage', () {
    final term = 'nyc';
    final location = Location(1, ' New York');
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherRepository = MockWeatherRepository();
      when(() => weatherRepository.searchForLocation(term: term))
          .thenAnswer((_) => Future.value([location]));
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

    testWidgets('renders SearchResults', (tester) async {
      await tester.pumpWidget(RepositoryProvider.value(
        value: weatherRepository,
        child: MaterialApp(
          home: SearchPage(),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(SearchForm), findsOneWidget);
      await tester.enterText(find.byKey(Key('searchBar_textField')), 'nyc');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(find.byType(SearchResults), findsOneWidget);
    });

    group('errors', () {
      final term = 'nyc';
      setUp(() {
        weatherRepository = MockWeatherRepository();
        when(() => weatherRepository.searchForLocation(term: term))
            .thenThrow((_) => Exception('error'));
      });

      testWidgets('renders SearchPage error view', (tester) async {
        await tester.pumpWidget(RepositoryProvider.value(
          value: weatherRepository,
          child: MaterialApp(
            home: SearchPage(),
          ),
        ));
        await tester.pumpAndSettle();
        await tester.enterText(find.byKey(Key('searchBar_textField')), 'nyc');
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pumpAndSettle();
        expect(find.text('Error searching for that location'), findsOneWidget);
      });
    });
  });
}
