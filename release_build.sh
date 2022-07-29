#!/bin/bash

BUILD_NUMBER=`cat pubspec.yaml | grep version | awk '{print $NF}' | awk -F '.' '{print $NF}'`
BUILD_NUMBER=$[BUILD_NUMBER+1]

OS_TYPE=`uname`

if [[ $OS_TYPE == "Darwin" ]]; then
    sed -Ei '' "s/version: (.*)\.([0-9]+$)/version: \1\.$BUILD_NUMBER/g" pubspec.yaml
elif [[ $OS_TYPE == "Linux" ]]; then
    sed -Ei "s/version: (.*)\.([0-9]+$)/version: \1\.$BUILD_NUMBER/g" pubspec.yaml
fi

# get the version in pubspec.yam
VERSION=`cat pubspec.yaml | grep version | awk '{print $NF}'`

# modify the version in dasubtitle.dart
if [[ $OS_TYPE == "Darwin" ]]; then
    sed -Ei '' "s/const VERSION_NUMBER = '[0-9.]+';$/const VERSION_NUMBER = '$VERSION';/g" bin/dasubtitle.dart
elif [[ $OS_TYPE == "Linux" ]]; then
    sed -Ei "s/const VERSION_NUMBER = '[0-9.]+';$/const VERSION_NUMBER = '$VERSION';/g" bin/dasubtitle.dart
fi

# build the app
dart compile exe bin/dasubtitle.dart

