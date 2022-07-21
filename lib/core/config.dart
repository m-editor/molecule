/*
 functions used to read, write and get config
*/

import 'dart:convert';

import 'package:json2yaml/json2yaml.dart';
import 'package:molecule/core/init.dart' show getConfigDir;
import 'dart:io' show File;

import 'package:yaml/yaml.dart' show loadYaml, YamlMap;

class Config {
  late Map<String, dynamic> content;
  Config() {
    content = getConfigData();
  }
}

/// get config file data
Map<String, dynamic> getConfigData() {
  final file = File("${getConfigDir()}/config.yml").readAsStringSync();
  final YamlMap content = loadYaml(file);
  return json.decode(json.encode(content));
}

/// write key to config file
void writeSetting(String key, dynamic value) {
  final content = getConfigData();
  if (content.containsKey(key)) {
    content[key] = value;
    final String yamlContent = json2yaml(content);
    File("${getConfigDir()}/config.yml").writeAsStringSync(yamlContent);
  }
}
