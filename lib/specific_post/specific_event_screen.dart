import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/appbar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/polls/poll_widget.dart';
import 'package:qc_collegeandcareer/storage.dart';

class SpecificEventScreen extends StatefulWidget {
  Event event;
  DecorationImage image;
  SpecificEventScreen({required this.event, required this.image});

  @override
  State<SpecificEventScreen> createState() => _SpecificEventScreenState();
}

class _SpecificEventScreenState extends State<SpecificEventScreen> {
  bool animated = false;
  double opacity = 0;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      if (!animated) {
        setState(() {
          opacity = 1;
          animated = true;
        });
      }
    });

    return Scaffold(
      backgroundColor: colorFourth,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  height: 75,
                ),
                Hero(
                  tag: widget.event.id + "image",
                  child: Opacity(
                    opacity: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.width * .6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: widget.image,
                          color: colorThird,
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                    ),
                  ),
                ),
                Hero(
                    tag: widget.event.id + "tag",
                    child: Container(
                      width: double.infinity,
                      height: 7,
                      color: colorMap[widget.event.tag],
                    )),
                Hero(
                  tag: widget.event.id + "title",
                  child: Container(
                    width: double.infinity,
                    height: 75,
                    decoration: BoxDecoration(
                        color: colorThird,
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.title,
                              style: styleTitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                timeAndDate(widget.event.startTime),
                
                AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.event.description,
                        style: styleBody,
                      ),
                    ),
                  ),
                ),(widget.event.poll != null)?
                PollWidget(poll: widget.event.poll!): Container(),
              ]),
            ),
            appBar(true, context, GlobalKey()),
          ],
        ),
      ),
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

  time = time + ":" + dateTime.minute.toString().padLeft(2, "0") + " "+ampm;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${dayList[dateTime.weekday - 1]}, ${monthList[dateTime.month - 1]} ${dateTime.day}",
          style: styleSubtitle,
        ),
        Container(width: 50,),
        Text(time, style: styleSubtitle)
      ],
    ),
  );
}
