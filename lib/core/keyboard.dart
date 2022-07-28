// file saving with strg + s
import 'package:flutter/cupertino.dart';
import 'package:molecule/core/file.dart';
import 'package:molecule/core/state.dart';

class SaveFileIntent extends Intent {
  const SaveFileIntent();
}

class SaveFileAction extends Action<SaveFileIntent> {
  SaveFileAction(this.index);

  final int index;

  @override
  Object? invoke(covariant SaveFileIntent intent) {
    final currentFile = provCot.read(tabProvider)[index];
    // check if unwritten changes exists
    if (provCot.read(fileCache.notifier).exists(currentFile.path)) {
      final fileContent =
          provCot.read(fileCache.notifier).cachedFileContent(currentFile.path);
      writeFileAsync(currentFile.path, fileContent);
      provCot.read(fileCache.notifier).remove(currentFile.path);
    }
    return null;
  }
}
