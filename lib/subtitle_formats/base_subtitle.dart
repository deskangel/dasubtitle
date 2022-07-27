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
