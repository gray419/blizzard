import 'package:blizzard/blizzard.dart';
import 'package:blizzard/search/view/search_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('Blizzard', () {
    testWidgets('renders SearchPage', (tester) async {
      await tester.pumpWidget(BlizzardApp(
        weatherRepository: MockWeatherRepository(),
      ));
      expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
