/*
this widget is used to restart the app on the fly
*/
import 'package:flutter/material.dart';
import 'package:molecule/core/config.dart';

class Moleculenix extends StatefulWidget {
  const Moleculenix({required this.child, Key? key}) : super(key: key);

  final Widget child;

  static void restartApp(BuildContext context) {
    reloadConf();
    context.findAncestorStateOfType<MoleculenixState>()!.restartApp();
  }

  @override
  // ignore: library_private_types_in_public_api
  MoleculenixState createState() => MoleculenixState();
}

class MoleculenixState extends State<Moleculenix> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
