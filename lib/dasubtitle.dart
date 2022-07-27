// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'dart:developer' as d;
import 'dart:io';

import 'package:dasubtitle/subtitle_formats/base_subtitle.dart';

///
/// `path`: absolute path to the file
/// `milliseconds`: positive and negative
///
void adjustTime(String path, int milliseconds, String outputPath) {
  d.log('$path,$milliseconds, $outputPath');
  if (milliseconds == 0) {
    return;
  }

  String? content = loadFile(path);
  if (content == null) {
    exitCode = 1;
    stderr.writeln('Failed to load the file "$path"');
    return;
  }

  var format = BaseSubtitle.fromExt(path);
  String? result = format.shiftTime(content, milliseconds);
  if (result == null) {
    exitCode = 2;
    return;
  }

  File file = File(outputPath);
  file.writeAsStringSync(result);
}

String? loadFile(String path) {
  File file = File(path);

  try {
    final content = file.readAsStringSync();
    return content;
  } on FileSystemException catch (e) {
    if (e.message.contains('utf-8')) {
      stderr.writeln('The file encoding is not utf-8, please use `iconv` to convert it to utf-8 then try again.');
    }
  }

  return null;
}
