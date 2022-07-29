// file saving with strg + s
import 'package:file_picker/file_picker.dart';
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
  Object? invoke(covariant SaveFileIntent intent) async {
    final currentFile = provCot.read(tabProvider)[index];
    // check if file is empty
    if (currentFile.isEmpty == true) {
      final path = await FilePicker.platform.saveFile(dialogTitle: "Save File");
      if (path != null) {
        writeFileAsync(
            path,
            provCot
                .read(fileCache.notifier)
                .cachedFileContent(currentFile.path));
        // get filename
        final String fileName = path.split("/").last;
        // get ext
        final String extension = fileName.split(".").last;
        // create new file
        final newFile = File.create(fileName, path, extension, false);
        // make file not empty
        provCot.read(tabProvider.notifier).replaceFileAt(index, newFile);
      }

      return null;
    }
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
