import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:molecule/core/color.dart';

class MoleculeBottomBar extends StatefulWidget {
  const MoleculeBottomBar({Key? key}) : super(key: key);

  @override
  State<MoleculeBottomBar> createState() => _MoleculeBottomBarState();
}

class _MoleculeBottomBarState extends State<MoleculeBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: MColorScheme.brighterBackgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [Text("test")],
        ));
  }
}
