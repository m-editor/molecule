import 'dart:ui';

import "package:flutter/material.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molecule/core/config.dart' show moleculeConfig;
import 'package:molecule/core/file.dart';
import 'package:molecule/core/state.dart';

class TextArea extends ConsumerStatefulWidget {
  const TextArea({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  ConsumerState<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends ConsumerState<TextArea> {
  late TextEditingController _textEditingController;
  List<File> data = [];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = ref.watch(tabProvider);
    return FutureBuilder(
        future: getAsyncFileContent(data[widget.index].path),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (ref.read(fileCache.notifier).exists(data[widget.index].path)) {
            _textEditingController.text = ref
                .read(fileCache.notifier)
                .cachedFileContent(data[widget.index].path);
          } else if (snapshot.hasData) {
            _textEditingController.text = snapshot.data as String;
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            return const Text("loading");
          }
          return TextField(
            autofocus: false,
            maxLines: null,
            style: TextStyle(
                fontFamily: moleculeConfig.fontSettings.fontFamily,
                fontSize: moleculeConfig.fontSettings.fontSize as double,
                fontWeight: moleculeConfig.fontSettings.fontWeight,
                fontFeatures: [
                  if (!moleculeConfig.fontSettings.fontLigatures) ...[
                    const FontFeature.disable("calt"),
                  ]
                ]),
            controller: _textEditingController,
            decoration: const InputDecoration.collapsed(hintText: ""),
            keyboardType: TextInputType.multiline,
            onChanged: (value) => ref
                .read(fileCache.notifier)
                .add(data[widget.index].path, value),
          );
        });
  }
}
