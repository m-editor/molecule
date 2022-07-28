import 'package:flutter/material.dart';

void welcomer(BuildContext context) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      anchorPoint: Offset.zero,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext content) {
        return FractionallySizedBox(
            heightFactor: .8,
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  color: Colors.white,
                ),
                height: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: const TextSpan(
                                text: "Welcome back! ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "Roboto"),
                                // fontFamily: "OpenSans"),
                                children: [
                              TextSpan(
                                  text: "👋",
                                  style: TextStyle(
                                      fontFamily: "NotoColorEmoji",
                                      fontSize: 20))
                            ])),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("Recent Projects"),
                        const SizedBox(height: 20),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [VCard(), VCard(), VCard()],
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("Workspaces"),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Icon(Icons.warning_amber),
                            Text("Coming soon")
                          ],
                        ),
                        const SizedBox(height: 50),
                        const Text("New project"),
                        const SizedBox(height: 20),
                        Row(
                          children: const [VCard(), VCard(), VCard()],
                        ),
                        ElevatedButton(
                            onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) =>
                                    Container(color: Colors.red, height: 120)),
                            child: const Text("click"))
                      ],
                    ))));
      });
}

class VCard extends StatelessWidget {
  const VCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) =>
                const SimpleDialog(title: Text("Hello"))),
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                height: 80,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.history),
                    Column(
                      children: const [Text("Title"), Text("Subtitle")],
                    )
                  ],
                ))));
  }
}
