import 'dart:io';

import 'package:dasubtitle/utils.dart';

class AssFormat {
  String? shiftTime(String content, int milliseconds) {
    List<String> result = [];
    List<String> lines = content.split('\n');
    for (var line in lines) {
      if (line.startsWith('Dialogue:')) {
        List<String> content = line.split(',');

        String? start = adjustTime(content[1], milliseconds);
        if (start == null) {
          stderr.writeln('Failed to adjust the start time "${content[1]}"');
          return null;
        }

        String? end = adjustTime(content[2], milliseconds);
        if (end == null) {
          stderr.writeln('Failed to adjust the end time "${content[2]}"');
          return null;
        }

        content[1] = start;
        content[2] = end;
        result.add(content.join(','));
      } else {
        result.add(line);
      }
    }
    return result.join('\n');
  }

  ///
  /// `shift`: in milliseconds
  ///
  String? adjustTime(String time, int shift) {
    Duration? duration = string2Duration(time);
    if (duration == null) {
      return null;
    }

    int milliseconds = duration.inMilliseconds;
    Duration result = Duration(milliseconds: milliseconds + shift);
    return result.toAssString();
  }

  Duration? string2Duration(String time) {
    List<String> parts = time.split(':');
    try {
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);

      List<String> tails = parts[2].split('.');
      int seconds = int.parse(tails[0]);
      int milliseconds = int.parse(tails[1]);

      return Duration(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds);
    } on FormatException catch (e) {
      stderr.writeln(e.message);
    }

    return null;
  }
}
