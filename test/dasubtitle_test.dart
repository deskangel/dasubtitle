// Copyright (c) 2022 ideskangel
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:test/test.dart';

import '../bin/dasubtitle.dart';

void main() {
  test('args', () {

    parseArgs(['--time 1000']);

    // expect(adjustTime(500), 42);
  });
}
