import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:molecule/core/color.dart';

class FileTree extends StatefulWidget {
  const FileTree({Key? key}) : super(key: key);

  @override
  State<FileTree> createState() => _FileTreeState();
}

class _FileTreeState extends State<FileTree> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: MColorScheme.backgroundColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * .2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(LucideIcons.folderTree, color: MColorScheme.textColor),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            MaterialButton(
              color: MColorScheme.accentColor,
              textColor: Colors.white,
              onPressed: () {},
              child: const Text("open directory"),
            )
          ],
        ));
  }
}
