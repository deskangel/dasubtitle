// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

extension DurationFormat on Duration {
  String toAssString({String milliDelimiter = '.'}) {
    var milliseconds = inMilliseconds;

    var hours = milliseconds ~/ Duration.millisecondsPerHour;
    milliseconds = milliseconds.remainder(Duration.millisecondsPerHour);

    if (milliseconds < 0) milliseconds = -milliseconds;

    var minutes = milliseconds ~/ Duration.millisecondsPerMinute;
    milliseconds = milliseconds.remainder(Duration.millisecondsPerMinute);

    var paddedMinutes = minutes < 10 ? '0$minutes' : '$minutes';

    var seconds = milliseconds ~/ Duration.millisecondsPerSecond;
    milliseconds = milliseconds.remainder(Duration.millisecondsPerSecond);

    var paddedSeconds = seconds < 10 ? '0$seconds' : '$seconds';

    var paddedMilliseconds = milliseconds.toString().padLeft(2, '0');
    return '$hours:$paddedMinutes:$paddedSeconds$milliDelimiter$paddedMilliseconds';
  }
}

