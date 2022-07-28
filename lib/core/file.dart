import 'package:file_picker/file_picker.dart';
import 'package:molecule/core/state.dart' show provCot, tabProvider, File;
import 'dart:io' as io;

void openFiles({bool allowMultiple = true}) async {
  final results =
      await FilePicker.platform.pickFiles(allowMultiple: allowMultiple);

  if (results == null) {
    return;
  }

  for (final resultFile in results.files) {
    final File file = File(resultFile.name, resultFile.path as String,
        resultFile.extension as String);
    if (provCot.read(tabProvider.notifier).contains(file.path)) {
      continue;
    }
    provCot.read(tabProvider.notifier).addTab(file);
  }
}

void writeFileAsync(String path, String content) {
  io.File(path).writeAsString(content);
  return;
}

String getFileContent(String path) {
  return io.File(path).readAsStringSync();
}

Future<String> getAsyncFileContent(String path) async {
  return (await io.File(path).readAsString());
}
