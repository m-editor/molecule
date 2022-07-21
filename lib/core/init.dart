/*
 code needed to initiate molecule
*/
import 'dart:io' show File, Platform, Directory;

import 'package:flutter/services.dart';

/// function to get config dir
String getConfigDir() {
  if (Platform.isWindows) {
    return "${Platform.environment["AppData"] as String}/molecule";
  } else {
    return "${Platform.environment["HOME"] as String}/.config/molecule";
  }
}

/// function to get dir where the extensions are located
String getExtDir() {
  if (Platform.isWindows) {
    return "${Platform.environment["AppData"] as String}/molecule";
  } else {
    return "${Platform.environment["HOME"] as String}/.molecule";
  }
}

///function, to check the configuration file
bool configExists() {
  final file = File("${getConfigDir()}/config.yml");
  if (file.existsSync()) return true;
  return false;
}

/// create directories
Future<void> createDirs() async {
  if (!Platform.isWindows) {
    await Directory(getConfigDir()).create();
    await Directory(getExtDir()).create();
  } else {
    await Directory(getConfigDir()).create();
  }
}

Future<void> copyConfig() async {
  final content = await rootBundle.loadString("assets/examples/config.yml");
  var file = await File("${getConfigDir()}/config.yml").create();
  await file.writeAsString(content);
}
