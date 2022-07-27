import 'dart:io';

import 'package:dasubtitle/dasubtitle.dart' as dasubtitle;
import 'package:args/args.dart';
import 'package:path/path.dart' as p;

///
/// `exitcode`:
///
///  * -1, arguments parsed error
///  *  0, successfully
///  *  1, input path error
///  *  2, failed to adjust times in the input file
///
void main(List<String> arguments) {
  final args = parseArgs(arguments);
  if (args == null) {
    exitCode = -1;
    return;
  }

  var path = args.rest.last;
  path = p.absolute(path);
  var outputPath = p.absolute(args['output'] ?? p.absolute('newsubtitle${p.extension(path)}'));

  dasubtitle.adjustTime(path, int.tryParse(args['time']) ?? 0, outputPath);

  stdout.writeln('The new content was saved into "$outputPath"');
}

ArgResults? parseArgs(List<String> arguments) {
  final argParser = ArgParser();
  argParser.addOption(
    'time',
    abbr: 't',
    help: 'in milliseconds. positive to delay and negative to rush',
    mandatory: true,
  );

  argParser.addOption(
    'output',
    abbr: 'o',
    help: 'if no outpath specified, the default one `newsubtitle.ass` will be used.',
  );

  try {
    final results = argParser.parse(arguments);
    return results;
  } on FormatException catch (_) {
    stderr.writeln('Failed to parse the arguments\n');

    stderr.writeln('usage: dasubtitle -t [+/-]milliseconds input_file -o output_file\n\n${argParser.usage}');
  }
  return null;
}
