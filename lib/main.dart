import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molecule/core/state.dart';
import 'package:molecule/screens/editor.dart';
import 'package:molecule/utils/menubar.dart' show initAppBar;
import 'package:molecule/widgets/restart.dart';

void main() {
  runApp(UncontrolledProviderScope(
    container: provCot,
    child: const Moleculenix(
      child: Molecule(),
    ),
  ));
}

class Molecule extends StatelessWidget {
  const Molecule({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initAppBar(context);
    return const MaterialApp(
      title: 'Molecule',
      // showPerformanceOverlay: true,
      home: Editor(),
      debugShowCheckedModeBanner: false,
    );
  }
}
