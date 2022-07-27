// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:io';

import 'package:dasubtitle/subtitle_formats/base_subtitle.dart';

class AssFormat extends BaseSubtitle {
  @override
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
}
