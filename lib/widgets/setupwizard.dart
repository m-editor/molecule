import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:molecule/core/color.dart';
import 'package:molecule/core/config.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:url_launcher/url_launcher.dart' show canLaunchUrl, launchUrl;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show
        ConsumerState,
        ConsumerStatefulWidget,
        StateNotifierProvider,
        StateProvider,
        StateNotifier;
import 'package:molecule/core/init.dart' show copyConfig, createDirs;
import 'package:molecule/utils/extensions.dart';

final langChoosen = StateProvider<bool>((ref) => false);
final dataContainer = StateNotifierProvider<_SetupData, Map<String, dynamic>>(
    (ref) => _SetupData());

class _SetupData extends StateNotifier<Map<String, dynamic>> {
  _SetupData() : super({"welcomer": true, "checkUpdates": false, "lang": null});

  void editValue(String key, dynamic value) {
    if (state.containsKey(key)) {
      state[key] = value;
      state = {...state};
    }
  }
}

void setupWizard(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: MColorScheme.backgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) => FractionallySizedBox(
          heightFactor: .8,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to Molecule!",
                        style: TextStyle(
                            color: MColorScheme.textColor,
                            fontSize: 20,
                            fontFamily: "Roboto"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "before you can get started, we need to configure a few things.",
                          style: TextStyle(color: MColorScheme.textColor)),
                      const SizedBox(
                        height: 120,
                      ),
                      Center(
                          child: SvgPicture.asset(
                        "assets/svg/setup.svg",
                        width: 300,
                        theme: SvgTheme(currentColor: MColorScheme.accentColor),
                      )),
                      const Spacer(),
                      Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * .9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        createDirs();
                                        copyConfig();
                                        Navigator.pop(context);
                                      },
                                      child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text("Skip all configuration",
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  color: MColorScheme
                                                      .accentColor)))),
                                  MaterialButton(
                                    onPressed: () async {
                                      createDirs();
                                      copyConfig();
                                      Navigator.pop(context);
                                      configurationPage(context);
                                    },
                                    color: MColorScheme.accentColor,
                                    textColor: Colors.white,
                                    child: const Text("Start"),
                                  )
                                ],
                              ))),
                      const SizedBox(height: 50)
                    ],
                  )))));
}

void configurationPage(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: MColorScheme.backgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) => FractionallySizedBox(
          heightFactor: .8,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Configuration",
                        style: TextStyle(
                            color: MColorScheme.textColor,
                            fontSize: 20,
                            fontFamily: "Roboto"),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width * .3,
                                  child: const WizardConfigSwitches())),
                          Expanded(
                              child: SvgPicture.asset(
                            "assets/svg/wizard.svg",
                            width: 300,
                            theme: SvgTheme(
                                currentColor: MColorScheme.accentColor),
                          ))
                        ],
                      ),
                      const Spacer(),
                      Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * .9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        //TODO: go back
                                      },
                                      child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text("Back",
                                              style: TextStyle(
                                                  fontFamily: "Roboto",
                                                  color: MColorScheme
                                                      .accentColor)))),
                                  const ContinueButton(),
                                ],
                              ))),
                      const SizedBox(height: 50),
                    ],
                  )))));
}

class WizardConfigSwitches extends ConsumerStatefulWidget {
  const WizardConfigSwitches({Key? key}) : super(key: key);

  @override
  ConsumerState<WizardConfigSwitches> createState() =>
      _WizardConfigSwitchesState();
}

class _WizardConfigSwitchesState extends ConsumerState<WizardConfigSwitches> {
  bool _checkForUpdates = false;
  bool _activateWelcomer = true;
  String? _lang;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
            inactiveTrackColor: MColorScheme.brighterBackgroundColor,
            subtitle: Text(
                "if enabled, Molecule will notify you about new versions and updates.",
                style: TextStyle(color: MColorScheme.textColor)),
            title: Text("Update notifications",
                style: TextStyle(color: MColorScheme.textColor)),
            value: _checkForUpdates,
            activeColor: MColorScheme.accentColor,
            secondary: Icon(Icons.campaign,
                color: _checkForUpdates ? Colors.red : Colors.grey),
            onChanged: (bool value) {
              ref.read(dataContainer.notifier).editValue("checkUpdates", value);
              setState(() {
                _checkForUpdates = value;
              });
            }),
        SwitchListTile(
            inactiveTrackColor: MColorScheme.brighterBackgroundColor,
            title: Text("Welcomer",
                style: TextStyle(color: MColorScheme.textColor)),
            subtitle: Text(
                "if enabled, Molecule shows you a welcome screen at every startup",
                style: TextStyle(color: MColorScheme.textColor)),
            value: _activateWelcomer,
            secondary: Icon(Icons.waving_hand,
                color: _activateWelcomer ? Colors.amber : Colors.grey),
            activeColor: MColorScheme.accentColor,
            onChanged: (bool value) {
              ref.read(dataContainer.notifier).editValue("welcomer", value);
              setState(() {
                _activateWelcomer = value;
              });
            }),
        ListTile(
          textColor: MColorScheme.textColor,
          leading: Icon(Icons.flag,
              color: _lang != null ? Colors.green : Colors.grey),
          title: const Text("Language"),
          subtitle: const Text(
              "The whole interface will then be displayed in that language."),
          trailing: DropdownButton<String>(
              style: TextStyle(color: MColorScheme.textColor),
              dropdownColor: MColorScheme.brighterBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              value: _lang,
              hint: Text("Choose",
                  style: TextStyle(color: MColorScheme.textColor)),
              items: ["english", "german", "french"]
                  .map<DropdownMenuItem<String>>((String lang) =>
                      DropdownMenuItem<String>(
                          value: lang, child: Text(lang.capitalize())))
                  .toList(),
              onChanged: (String? value) {
                ref.read(dataContainer.notifier).editValue("lang", value);
                setState(() {
                  _lang = value!;
                });
              }),
        ),
      ],
    );
  }
}

class ContinueButton extends ConsumerStatefulWidget {
  const ContinueButton({Key? key}) : super(key: key);

  @override
  ConsumerState<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends ConsumerState<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: ref.watch(dataContainer)["lang"] != null
          ? () {
              Navigator.pop(context);
              themePage(context);
            }
          : null,
      color: MColorScheme.accentColor,
      disabledColor: Colors.grey,
      textColor: Colors.white,
      child: const Text("continue"),
    );
  }
}

void themePage(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: MColorScheme.backgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      isScrollControlled: true,
      builder: (BuildContext context) => FractionallySizedBox(
          heightFactor: .8,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Appearance",
                          style: TextStyle(
                              color: MColorScheme.textColor,
                              fontSize: 20,
                              fontFamily: "Roboto"),
                        ),
                        const Spacer(),
                        const Center(
                            child: Icon(Icons.handyman,
                                color: Colors.grey, size: 100)),
                        const Center(
                            child: Text("Coming soon",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.grey))),
                        const Spacer(),
                        Center(
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * .9,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          //TODO: go back
                                        },
                                        child: MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child: Text("Back",
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    color: MColorScheme
                                                        .accentColor)))),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        finishPage(context);
                                      },
                                      color: MColorScheme.accentColor,
                                      disabledColor: Colors.grey,
                                      textColor: Colors.white,
                                      child: const Text("Continue"),
                                    )
                                  ],
                                ))),
                        const SizedBox(height: 50)
                      ])))));
}

void finishPage(BuildContext context) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      isScrollControlled: true,
      backgroundColor: MColorScheme.backgroundColor,
      builder: (BuildContext context) => FractionallySizedBox(
          heightFactor: .8,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            RichText(
                              text: TextSpan(
                                  text: "Thank you for using Molecule!",
                                  style: TextStyle(
                                      color: MColorScheme.textColor,
                                      fontSize: 20,
                                      fontFamily: "Roboto"),
                                  children: const [
                                    TextSpan(
                                        text: "❤️",
                                        style: TextStyle(
                                            fontFamily: "NotoColorEmoji"))
                                  ]),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            IconButton(
                                onPressed: () async => (await canLaunchUrl(
                                        Uri.parse("https://github.com")))
                                    ? (await launchUrl(Uri.parse(
                                        "https://github.com/m-editor/molecule")))
                                    : null,
                                icon: const FaIcon(FontAwesomeIcons.github))
                          ]),
                          SvgPicture.asset("assets/svg/finish.svg",
                              width: 300,
                              theme: SvgTheme(
                                  currentColor: MColorScheme.accentColor))
                        ],
                      ),
                      const Spacer(),
                      Center(
                          child: SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        child: Flex(
                          mainAxisAlignment: MainAxisAlignment.end,
                          direction: Axis.horizontal,
                          children: const [FinishButton()],
                        ),
                      )),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  )))));
}

class FinishButton extends ConsumerStatefulWidget {
  const FinishButton({Key? key}) : super(key: key);

  @override
  ConsumerState<FinishButton> createState() => _FinishButtonState();
}

class _FinishButtonState extends ConsumerState<FinishButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        ref
            .read(dataContainer)
            .forEach((key, value) => writeSetting(key, value));
        Navigator.pop(context);
      },
      color: MColorScheme.accentColor,
      disabledColor: Colors.grey,
      textColor: Colors.white,
      child: const Text("Start using"),
    );
  }
}
