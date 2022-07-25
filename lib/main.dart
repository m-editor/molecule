import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molecule/core/state.dart';
import 'package:molecule/screens/editor.dart';

void main() {
  runApp(UncontrolledProviderScope(
    container: provCot,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Molecule',
      // showPerformanceOverlay: true,
      home: Editor(),
      debugShowCheckedModeBanner: false,
    );
  }
}
