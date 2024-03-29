import 'package:pomodoro_timer/core/utils/time_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TimeConverter timeConverter;

  setUp(() {
    timeConverter = TimeConverter();
  });

  group("TimeConverter", () {
    test('convert seconds to formatted string using `fromSeconds` methods', () {
      expect(timeConverter.fromSeconds(60), '01:00');
      expect(timeConverter.fromSeconds(125), '02:05');
      expect(timeConverter.fromSeconds(3600), '01:00:00');
      expect(timeConverter.fromSeconds(3660), '01:01:00');
      expect(timeConverter.fromSeconds(7323), '02:02:03');
    });

    test('convert seconds to minutes', () {
      expect(timeConverter.secondToMinutes(120), 2);
      expect(timeConverter.secondToMinutes(1500), 25);
    });

    test('convert minutes to second', () {
      expect(timeConverter.minuteToSecond(1), 60);
      expect(timeConverter.minuteToSecond(25), 1500);
    });

    test('convert formatted String to seconds using `convertStringToSeconds` method', () {
      expect(timeConverter.convertStringToSeconds('01:00'), 60);
      expect(timeConverter.convertStringToSeconds('01:10'), 70);
      expect(timeConverter.convertStringToSeconds('01:00:00'), 3600);
      expect(timeConverter.convertStringToSeconds('10:30:25'), 37825);
    });
  });
}
