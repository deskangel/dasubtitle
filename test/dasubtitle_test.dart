// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:dasubtitle/subtitle_formats/base_subtitle.dart';
import 'package:test/test.dart';

const ASS_CONTENT_1 = '''
[Events]
Format: Marked, Start, End, Style, Name, MarginL, MarginR, MarginV, Effect, Text
Dialogue: Marked=0,0:01:42.60,0:01:45.02,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:01:45.10,0:01:46.85,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:01:46.94,0:01:51.36,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:01:51.98,0:01:53.86,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:01:53.94,0:01:58.99,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:01:59.45,0:02:03.74,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:03.83,0:02:05.70,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:05.79,0:02:09.12,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:09.16,0:02:11.25,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:11.33,0:02:12.79,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:12.83,0:02:14.88,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:14.96,0:02:16.42,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:16.50,0:02:19.88,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:20.67,0:02:23.30,Default,NTP,0000,0000,0000,!Effect, ,
Dialogue: Marked=0,0:02:23.34,0:02:27.26,Default,NTP,0000,0000,0000,!Effect, ,
''';

const ASS_CONTENT_2 = '''
Dialogue: 0,0:06:52.83,0:06:53.99,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:06:59.87,0:07:02.16,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:03.54,0:07:05.16,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:12.18,0:07:13.17,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:13.26,0:07:14.42,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:36.08,0:07:37.74,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:37.83,0:07:38.91,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:39.00,0:07:40.33,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:45.00,0:07:46.46,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:53.93,0:07:54.92,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:55.01,0:07:57.09,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:58.02,0:07:59.60,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:07:59.68,0:08:00.93,*Default,NTP,0000,0000,0000,,
Dialogue: 0,0:08:01.10,0:08:02.81,*Default,NTP,0000,0000,0000,,
''';

void main() {
  test('adjustTime for ass full', () {
    var format = BaseSubtitle.fromExt('../test.ass');
    String? result = format.shiftTime(ASS_CONTENT_1, 1100);
    expect(result != null, true);

    expect(result!.contains('0:02:24.134,0:02:28.126,'), true);
  });
  test('adjustTime for ass range', () {
    var format = BaseSubtitle.fromExt('../test.ass');
    String? result = format.shiftTime(
      ASS_CONTENT_1,
      1100,
      rangeBegin: format.parse2Milliseconds('0:01:59.45'),
      rangeEnd: format.parse2Milliseconds('0:02:19.88'),
    );
    expect(result != null, true);

    expect(result!.contains('0:01:53.94,0:01:58.99,'), true);
    expect(result.contains('0:01:42.60,0:01:45.02,'), true);

    expect(result.contains('0:02:00.145,0:02:04.174,'), true); // start range
    expect(result.contains('0:02:17.150,0:02:20.188,'), true); // end range

    expect(result.contains('0:02:20.67,0:02:23.30,'), true);
    expect(result.contains('0:02:23.34,0:02:27.26,'), true);
  });
  test('adjustTime for ass range begin to full', () {
    var format = BaseSubtitle.fromExt('../test.ass');
    String? firstPhase = format.shiftTime(
      ASS_CONTENT_2,
      -2000,
    );
    {
      var contents = firstPhase!.split('\n');
      expect(contents[5].contains('0:07:34.08,0:07:35.74'), true);
      expect(contents[6].contains('0:07:35.83,0:07:36.91'), true);

      print('$firstPhase\n');
    }

    String? result = format.shiftTime(
      firstPhase,
      -6000,
      rangeBegin: format.parse2Milliseconds('0:07:34.08'),
    );
    expect(result != null, true);

    print(result);
    var contents = result!.split('\n');

    expect(contents[4].contains('0:07:11.26,0:07:12.42'), true);

    print(contents[5]);
    expect(contents[5].contains('0:07:28.08,0:07:29.74'), true);
    expect(contents[6].contains('0:07:29.83,0:07:30.91'), true);

    expect(contents[7].contains('0:07:31.00,0:07:32.33'), true);
  });
}
