import 'package:flutter/material.dart';
import 'package:molecule/core/color.dart';
import 'package:molecule/widgets/bottombar.dart';
import 'package:molecule/utils/extensions.dart';
import 'package:molecule/widgets/setupwizard.dart';

class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MoleculeBottomBar(),
        backgroundColor: MColorScheme.backgroundColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Image.asset("assets/logo/logo.trans.png"),
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  // color: Colors.green,
                  color: MColorScheme.backgroundColor,
                  width: MediaQuery.of(context).size.width * .2,
                ),
                Container(
                  child: Text("Vali"),
                  height: MediaQuery.of(context).size.height,
                  color: MColorScheme.backgroundColor.withOpacity(.6),
                  width: MediaQuery.of(context).size.width * .8,
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.only(top: 50, right: 50),
                child: const Banner(
                  message: "Preview",
                  location: BannerLocation.bottomStart,
                ),
              ),
            ),
          ]),
        ));
  }
}
