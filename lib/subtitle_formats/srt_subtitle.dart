// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:convert';
import 'dart:io';

import 'package:dasubtitle/subtitle_formats/base_subtitle.dart';

class SrtFormat extends BaseSubtitle {
  @override
  String? shiftTime(String content, int milliseconds, {int? rangeBegin, int? rangeEnd}) {
    List<String> result = [];

    LineSplitter ls = LineSplitter();
    List<String> lines = ls.convert(content);

    for (var line in lines) {
      if (line.contains('-->')) {
        List<String> content = line.split('-->');
        String? start = adjustTime(content[0], milliseconds, rangeBegin: rangeBegin, rangeEnd: rangeEnd);
        if (start == null) {
          stderr.writeln('Failed to adjust the start time "${content[0]}", but continue.');
          result.add(line);

          continue;
        }

        String? end = adjustTime(content[1], milliseconds, rangeBegin: rangeBegin, rangeEnd: rangeEnd);
        if (end == null) {
          stderr.writeln('Failed to adjust the end time "${content[1]}", but continue.');
          result.add(line);

          continue;
        }

        result.add('$start --> $end');
      } else {
        result.add(line);
      }
    }

    return result.join('\n');
  }

  @override
  String get millisecondsDelimiter => ',';
}
