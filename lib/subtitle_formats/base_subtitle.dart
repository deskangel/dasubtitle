// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:io';

import 'package:dasubtitle/subtitle_formats/ass_subtitle.dart';
import 'package:dasubtitle/subtitle_formats/srt_subtitle.dart';
import 'package:dasubtitle/utils.dart';
import 'package:path/path.dart' as p;

abstract class BaseSubtitle {
  static const int MAX_END = 0x7fffffff;

  BaseSubtitle();

  factory BaseSubtitle.fromExt(String path) {
    String ext = p.extension(path);
    switch (ext.toLowerCase()) {
      case '.ass':
        return AssFormat();
      case '.srt':
        return SrtFormat();
      default:
        throw UnimplementedError();
    }
  }

  String? shiftTime(String content, int milliseconds, {int? rangeBegin, int? rangeEnd});

  ///
  /// `shift`: in milliseconds
  ///
  String? adjustTime(String time, int shift, {int? rangeBegin, int? rangeEnd}) {
    rangeBegin ??= 0;
    rangeEnd ??= MAX_END;

    Duration? duration = string2Duration(time.trim());
    if (duration == null) {
      return null;
    }

    int milliseconds = duration.inMilliseconds;

    if (milliseconds < rangeBegin || milliseconds > rangeEnd) {
      return time;
    }

    Duration result = Duration(milliseconds: milliseconds + shift);
    return result.toAssString(milliDelimiter: millisecondsDelimiter);
  }

  int? parse2Milliseconds(String? time) {
    if (time == null) {
      return null;
    }

    Duration? duration = string2Duration(time.trim());
    if (duration == null) {
      return null;
    }

    return duration.inMilliseconds;
  }

  ///
  /// `delimiter`: the milliseconds delimiter
  ///
  Duration? string2Duration(String time) {
    List<String> parts = time.trim().split(':');
    try {
      int hours = int.parse(parts[0]);
      int minutes = int.parse(parts[1]);

      List<String> tails = parts[2].split(millisecondsDelimiter);
      int seconds = int.parse(tails[0]);
      int milliseconds = int.parse(tails[1]);

      return Duration(hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds);
    } on FormatException catch (e) {
      stderr.writeln(e.message);
    }

    return null;
  }

  String get millisecondsDelimiter;
}
