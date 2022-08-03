import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/Navigation/bottom_bar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';


import 'package:qc_collegeandcareer/home/home_screen.dart';

import 'package:qc_collegeandcareer/events/specific_event_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> sections = <Widget>[];

    appSetup.contactSetup.forEach((((key, value) {
      sections.add(homeScreenSectionBuilder(context, key));
    })));

    return Stack(
      children: [
        GradientBackground(color: colorAccentSecond),
        Scaffold(
          backgroundColor:
              getColorFromList(appSetup.colorMap["colorThird"]).withOpacity(.3),
          body: SafeArea(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: Column(children: [
                          ...sections
                        ]),
                      ),
                    ),
                  ),
                  BottomBar(),
                ]),
          ),
        ),
      ],
    );
  }
}
