import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/Navigation/bottom_bar.dart';
import 'package:qc_collegeandcareer/Navigation/appbar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';


// ignore: must_be_immutable
class SpecificEventScreen extends StatefulWidget {
  Event event;
  DecorationImage image;
  SpecificEventScreen({Key? key, required this.event, required this.image}) : super(key: key);

  @override
  State<SpecificEventScreen> createState() => _SpecificEventScreenState();
}

class _SpecificEventScreenState extends State<SpecificEventScreen>
    with TickerProviderStateMixin {
  bool animated = false;
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!animated) {
        setState(() {
          opacity = 1;
          animated = true;
        });
      }
    });

    return Stack(
      children: [
        GradientBackground(
          color: colorMap[widget.event.tag]!,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                            width: double.infinity,
                            height: 60,
                            color: getColorFromList(
                                appSetup.colorMap["colorFourth"]),
                          ),
                          Hero(
                            tag: "${widget.event.id}image",
                            child: Opacity(
                              opacity: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.width * .6,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: widget.image,
                                    color: getColorFromList(appSetup.colorMap["colorThird"]),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(0))),
                              ),
                            ),
                          ),
                          Hero(
                              tag: "${widget.event.id}tag",
                              child: Container(
                                width: double.infinity,
                                height: 7,
                                color: colorMap[widget.event.tag],
                              )),
                          Hero(
                            tag: "${widget.event.id}title",
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.75),
                                        blurRadius: 15,
                                        offset: const Offset(5, 5))
                                  ],
                                  color: getColorFromList(
                                      appSetup.colorMap["colorFourth"]),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(36),
                                      bottomRight: Radius.circular(36))),
                              child: Material(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 36, vertical: 12),
                                  child: Center(
                                    child: Text(
                                      widget.event.title,
                                      style: styleTitle,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(.75),
                                        blurRadius: 15,
                                        offset: const Offset(7, 7))
                                  ],
                                  color: getColorFromList(
                                      appSetup.colorMap["colorFourth"]),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(25))),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  children: [
                                    (widget.event.startTime != null)
                                        ? timeAndDate(widget.event.startTime!)
                                        : Container(),
                                    (widget.event.startTime != null)
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Divider(
                                              color: colorMap[widget.event.tag],
                                              thickness: 4,
                                            ))
                                        : Container(),
                                    AnimatedOpacity(
                                      opacity: opacity,
                                      duration: const Duration(seconds: 1),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: SelectableText(
                                          widget.event.description,
                                          style: styleBody,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    BottomBar(
                      popBeforeNav: true,
                    )
                  ],
                ),
                appBar(context)
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget timeAndDate(DateTime dateTime) {
  List<String> monthList = <String>[
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  List<String> dayList = <String>[
    "Sunday",
    "Monday",
    "Tueday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  String time = "";
  String ampm = "AM";

  if (dateTime.hour > 12) {
    time = (dateTime.hour - 12).toString();
    ampm = "PM";
  } else {
    time = dateTime.hour.toString();
  }

  time = "$time:${dateTime.minute.toString().padLeft(2, "0")} $ampm";

  return Wrap(
    children: [
      Text(
        "${dayList[dateTime.weekday - 1]}, ${monthList[dateTime.month - 1]} ${dateTime.day}  ",
        style: styleSubtitle,
      ),
      Text(time, style: styleSubtitle)
    ],
  );
}

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
              colors: [widget.color, getColorFromList(appSetup.colorMap["colorThird"])])),
    );
  }
}
