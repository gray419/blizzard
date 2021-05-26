import 'package:test/test.dart';
import 'package:weather_repository/src/extensions/double_extensions.dart';

void main() {
  test('test toFahrenheit', () {
    expect(13.0.toFahrenheit(), 55.4);
  });

  test('test toCelsius', () {
    expect(55.4.toCelsius(), 13.0);
  });
}
