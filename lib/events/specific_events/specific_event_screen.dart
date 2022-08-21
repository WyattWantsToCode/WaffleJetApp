import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/Navigation/bottom_bar.dart';
import 'package:qc_collegeandcareer/Navigation/appbar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/events/specific_events/image.dart';
import 'package:qc_collegeandcareer/events/specific_events/tag.dart';
import 'package:qc_collegeandcareer/events/specific_events/time_and_date.dart';
import 'package:qc_collegeandcareer/events/specific_events/title.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';

// ignore: must_be_immutable

bool editMode = false;

class SpecificEventScreen extends StatefulWidget {
  Event event;
  DecorationImage image;
  SpecificEventScreen({Key? key, required this.event, required this.image})
      : super(key: key);

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
          color: getColorFromTag(widget.event.tag),
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
                          ImageWidget(event: widget.event, image: widget.image),
                          TagWidget(event: widget.event,),
                          TitleWidget(event: widget.event),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25))),
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
                                              color: getColorFromTag(widget.event.tag),
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





