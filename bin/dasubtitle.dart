import 'dart:io';

import 'package:dasubtitle/dasubtitle.dart' as dasubtitle;
import 'package:args/args.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  final args = parseArgs(arguments);
  if (args == null) {
    return;
  }

  var path = args.rest.last;
  path = p.absolute(path);
  var outputPath = p.absolute(args['output'] ?? p.absolute('newsubtitle${p.extension(path)}'));

  dasubtitle.adjustTime(path, int.tryParse(args['time']) ?? 0, outputPath);
}

ArgResults? parseArgs(List<String> arguments) {
  final argParser = ArgParser();
  argParser.addOption(
    'time',
    abbr: 't',
    help: 'in milliseconds. positive to delay and negative to rush',
    mandatory: true,
  );

  argParser.addOption('output', abbr: 'o');

  try {
    final results = argParser.parse(arguments);
    return results;
  } on FormatException catch (_) {
    stderr.writeln('dasubtitle -t [+/-]milliseconds input_file -o output_file\n\n${argParser.usage}');
  }
  return null;
}
