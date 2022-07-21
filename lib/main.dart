import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:molecule/core/init.dart';
import 'package:molecule/screens/editor.dart';
import 'package:molecule/widgets/setupwizard.dart';
import 'package:molecule/widgets/welcomer.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      ElevatedButton(
        child: Text("click me"),
        onPressed: () => welcomer(context),
      ),
      ElevatedButton(
          onPressed: () => configurationPage(context),
          child: Text("configpage")),
      ElevatedButton(
          onPressed: () => themePage(context), child: Text("themeing")),
      ElevatedButton(
          onPressed: () async {
            setupWizard(context);
          },
          child: Text("Start setup wizard")),
      if (!configExists()) ...[
        ElevatedButton(
            onPressed: () => setupWizard(context),
            child: Text("Start setup wizard"))
      ]
    ])));
  }
}
