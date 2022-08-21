import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';

Color colorFirst = const Color.fromRGBO(231, 246, 242, 1);
Color colorSecond = const Color.fromRGBO(165, 201, 202, 1);
Color colorThird = const Color.fromRGBO(57, 91, 100, 1);
Color colorFourth = const Color.fromRGBO(44, 51, 51, 1);

Color colorAccent = const Color.fromRGBO(92, 68, 152, 50);
Color colorAccentSecond = const Color.fromRGBO(96, 68, 52, 50);

Color colorTransparent = const Color.fromRGBO(57, 91, 100, 50);

Map<String, Color> colorMap = {
  "Events": Colors.yellow.withOpacity(.75),
  "Contacts": Colors.green.withOpacity(.75),
  "Service Projects": Colors.blue.withOpacity(.75)
};

TextStyle styleTitle = GoogleFonts.robotoCondensed(textStyle:  TextStyle(color: colorFirst, fontSize: 48, fontWeight: FontWeight.w300));
TextStyle styleSubtitle = GoogleFonts.cabin(textStyle:  TextStyle(color: colorFirst, fontSize: 28, fontWeight: FontWeight.w400));
TextStyle styleBody = GoogleFonts.cabin(textStyle:  TextStyle(color: colorFirst, fontSize: 18, fontWeight: FontWeight.w200));

// ignore: must_be_immutable
class GradientBackground extends StatefulWidget {
  Color color;
  GradientBackground({Key? key, required this.color}) : super(key: key);

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground>
    with SingleTickerProviderStateMixin {
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];

  int alignmentIndex = 0;
  bool cancelTimer = false;

  _startBgColorAnimationTimer() {
    ///Animating for the first time.
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      alignmentIndex++;
      setState(() {});
    });

    const interval = Duration(seconds: 30);
    Timer.periodic(
      interval,
      (Timer timer) {
        if (mounted) {
          alignmentIndex++;
          setState(() {});
        }
      },
    );
  }

  @override
  void initState() {
    _startBgColorAnimationTimer();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 30),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: alignmentList[alignmentIndex % alignmentList.length],
              end: alignmentList[(alignmentIndex + 2) % alignmentList.length],
              colors: [
            widget.color,
            getColorFromList(appSetup.colorMap["colorThird"])
          ])),
    );
  }
}
