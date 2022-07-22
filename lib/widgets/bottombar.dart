import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:molecule/core/color.dart';
import 'package:molecule/core/events.dart' show FileTreeToggleNotification;

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
        child: SizedBox(
            height: 25,
            width: MediaQuery.of(context).size.width,
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () =>
                              FileTreeToggleNotification().dispatch(context),
                          height: 12,
                          minWidth: 12,
                          padding: EdgeInsets.zero,
                          child: FaIcon(FontAwesomeIcons.folderTree,
                              color: MColorScheme.textColor, size: 12),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Molecule v0.3",
                          style: TextStyle(color: MColorScheme.textColor),
                        )
                      ],
                    )
                  ],
                ))));
  }
}
