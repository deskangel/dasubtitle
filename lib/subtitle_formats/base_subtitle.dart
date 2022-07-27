// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:io';

import 'package:dasubtitle/utils.dart';

abstract class BaseSubtitle {
  String? shiftTime(String content, int milliseconds);

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
