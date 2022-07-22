import 'package:flutter/material.dart';
import 'package:molecule/core/color.dart';
import 'package:molecule/core/events.dart';
import 'package:molecule/widgets/bottombar.dart';
import 'package:molecule/widgets/filetree.dart';
import 'package:molecule/widgets/tabview.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  State<Editor> createState() => _EditorState();
}

int initPosition = 0;

class _EditorState extends State<Editor> {
  bool _fileTree = true;
  final data = [
    "Laura",
    "Leo",
    "Liam",
    "Lara",
    "Larissa",
  ];

  @override
  Widget build(BuildContext context) {
    return NotificationListener<FileTreeToggleNotification>(
        onNotification: (notification) {
          setState(() {
            _fileTree = !_fileTree;
          });
          return true;
        },
        child: Scaffold(
            bottomNavigationBar: const MoleculeBottomBar(),
            backgroundColor: MColorScheme.backgroundColor,
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(alignment: AlignmentDirectional.center, children: [
                Image.asset("assets/logo/logo.trans.png"),
                Row(
                  children: [
                    if (_fileTree) ...[const FileTree()],
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: MColorScheme.backgroundColor.withOpacity(.6),
                      width: _fileTree
                          ? MediaQuery.of(context).size.width * .8
                          : MediaQuery.of(context).size.width,
                      child: CostumTabView(
                          initPosition: initPosition,
                          itemCount: data.length,
                          tabBuilder: (context, index) =>
                              Tab(child: Text(data[index])),
                          pageBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.all(15),
                                child: TextField(
                                  maxLines: null,
                                  decoration:
                                      InputDecoration.collapsed(hintText: ""),
                                  keyboardType: TextInputType.multiline,
                                ),
                              ),
                          onPositionChange: (val) => initPosition = val,
                          onScroll: (_) {}),
                    ),
                  ],
                ),
              ]),
            )));
  }
}
