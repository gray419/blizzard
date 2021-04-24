import 'package:blizzard/search/bloc/search_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('SearchCubit', () {
    test('initial state is SearchState.initial', () {
      final weatherRepository = MockWeatherRepository();
      final searchCubit = SearchCubit(weatherRepository);
      expect(searchCubit.state, const SearchState.initial());
      searchCubit.close();
    });

    group('search for location', () {
      final term = 'nyc';
      final location = Location(1, ' New York');
      late WeatherRepository weatherRepository;

      setUp(() {
        weatherRepository = MockWeatherRepository();
        when(() => weatherRepository.searchForLocation(term: term))
            .thenAnswer((_) => Future.value([location]));
      });

      blocTest<SearchCubit, SearchState>(
        'invoke searchForLocation on repository',
        build: () => SearchCubit(weatherRepository),
        act: (cubit) => cubit.searchForLocation(term),
        verify: (_) => verify(
          () => weatherRepository.searchForLocation(term: term),
        ).called(1),
      );

      blocTest<SearchCubit, SearchState>(
        'emits loading, success when searchForLocation succeeds',
        build: () => SearchCubit(weatherRepository),
        act: (cubit) => cubit.searchForLocation(term),
        expect: () => <SearchState>[
          SearchState.loading(),
          SearchState.success([location])
        ],
      );

      blocTest<SearchCubit, SearchState>(
        'emits loading, error when searchForLocation throws',
        build: () {
          when(() => weatherRepository.searchForLocation(term: term))
              .thenThrow((_) => Exception('Error'));
          return SearchCubit(weatherRepository);
        },
        act: (cubit) => cubit.searchForLocation(term),
        expect: () =>
            const <SearchState>[SearchState.loading(), SearchState.failure()],
      );
    });
  });
}
