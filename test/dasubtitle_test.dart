// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:dasubtitle/subtitle_formats/base_subtitle.dart';
import 'package:test/test.dart';

const ASS_CONTENT = '''
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

void main() {
  test('adjustTime for ass full', () {
    var format = BaseSubtitle.fromExt('../test.ass');
    String? result = format.shiftTime(ASS_CONTENT, 1100);
    expect(result != null, true);

    expect(result!.contains('0:02:24.134,0:02:28.126,'), true);
  });
  test('adjustTime for ass range', () {
    var format = BaseSubtitle.fromExt('../test.ass');
    String? result = format.shiftTime(
      ASS_CONTENT,
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
}
