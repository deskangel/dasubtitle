#!/bin/bash

BUILD_NUMBER=`cat .build_number`
BUILD_NUMBER=$[BUILD_NUMBER+1]

sed -Ei '' "s/version: (.*)\.([0-9]+$)/version: \1\.$BUILD_NUMBER/g" pubspec.yaml

# get the version in pubspec.yam
VERSION=`cat pubspec.yaml | grep version | awk '{print $NF}'`

# modify the version in dasubtitle.dart
sed -Ei '' "s/const VERSION_NUMBER = '[0-9.]+';$/const VERSION_NUMBER = '$VERSION';/g" bin/dasubtitle.dart

# build the app
dart compile exe bin/dasubtitle.dart

echo $BUILD_NUMBER > .build_number
