import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wordnet_dictionary_app/bridge_generated.dart';
import 'package:wordnet_dictionary_app/dictionary_app.dart';

const base = "rust";
final path = Platform.isWindows ? "$base.dll" : "lib$base.so";
final dylib = Platform.isIOS
    ? DynamicLibrary.process()
    : Platform.isMacOS
        ? DynamicLibrary.executable()
        : DynamicLibrary.open(path);

final api = RustImpl(dylib);

void main() async {
  runApp(const Main());
}

