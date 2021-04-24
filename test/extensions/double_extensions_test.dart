import 'package:blizzard/extensions/double_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test toFahrenheit', () {
    expect(13.0.toFahrenheit(), 55.4);
  });

  test('test toCelsius', () {
    expect(55.4.toCelsius(), 13.0);
  });
}
