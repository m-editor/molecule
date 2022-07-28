import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molecule/core/color.dart';
import 'package:molecule/core/events.dart';
import 'package:molecule/core/keyboard.dart';
import 'package:molecule/core/state.dart';
import 'package:molecule/widgets/bottombar.dart';
import 'package:molecule/widgets/filetree.dart';
import 'package:molecule/widgets/tabview.dart';
import 'package:molecule/widgets/textarea.dart';

class Editor extends ConsumerStatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  ConsumerState<Editor> createState() => _EditorState();
}

int initPosition = 0;

class _EditorState extends ConsumerState<Editor> {
  bool _fileTree = true;
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
                            Tab(child: Text(data[index].name)),
                        pageBuilder: (context, index) => Shortcuts(
                            shortcuts: <LogicalKeySet, Intent>{
                              LogicalKeySet(LogicalKeyboardKey.control,
                                      LogicalKeyboardKey.keyS):
                                  const SaveFileIntent(),
                            },
                            child: Actions(
                                actions: <Type, Action<Intent>>{
                                  SaveFileIntent: SaveFileAction(index),
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: TextArea(index: index)))),
                        onPositionChange: (val) {
                          initPosition = val;
                        },
                        onScroll: (_) {},
                        onUpdate: (currentCount) {},
                      ),
                    ),
                  ],
                ),
              ]),
            )));
  }
}
