import 'package:flutter/material.dart';
import 'package:menubar/menubar.dart'
    show setApplicationMenu, NativeSubmenu, NativeMenuDivider, NativeMenuItem;
import 'package:molecule/core/file.dart';

void initAppBar(BuildContext context) {
  setApplicationMenu(<NativeSubmenu>[
    NativeSubmenu(label: "File", children: <NativeMenuItem>[
      NativeMenuItem(label: "Open file", onSelected: () => openFiles())
    ]),
    NativeSubmenu(label: "Help", children: [
      NativeMenuItem(label: "Get help", onSelected: () => ""),
      NativeMenuItem(label: "Report bug", onSelected: () => ""),
      NativeMenuItem(label: "Version notes", onSelected: () => ""),
      const NativeMenuDivider(),
      NativeMenuItem(
          label: "About Molecule",
          onSelected: () => showAboutDialog(
                context: context,
                applicationName: "Molecule",
              ))
    ])
  ]);
}
