import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/calendar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/home/home_screen.dart';

Widget appBar(
    BuildContext context) {
  List<Widget> widgetList = [
    
  ];
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IndexedStack(children: [
        
        backArrow(context),
      ],),
      
    ],
  );
}

double width = 60;
double height = 60;

Widget settingsIcon(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: colorFourth,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25))),
    width: width,
    height: height,
    child: TextButton(
      onPressed: () {},
      child: Hero(
        tag: "settings",
        child: Center(
          child: Icon(
            Icons.settings,
            color: colorSecond,
            size: 30,
          ),
        ),
      ),
    ),
  );
}

Widget hamburger(BuildContext context, GlobalKey<ScaffoldState> key) {
  return Container(
    decoration: BoxDecoration(
        color: colorFourth,
        borderRadius:
            const BorderRadius.only(bottomRight: Radius.circular(25))),
    width: width,
    height: height,
    child: TextButton(
      onPressed: (() {
        key.currentState!.openDrawer();
      }),
      child: Center(
        child: Opacity(
          opacity: 0,
          child: Container(
            height: 25,
            width: 30,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(tag: "1", child: ham()),
                  Hero(tag: "2", child: ham()),
                  Hero(tag: "3", child: ham()),
                ]),
          ),
        ),
      ),
    ),
  );
}

Widget ham() {
  return Container(
    width: 30,
    height: 5,
    decoration: BoxDecoration(
        color: colorSecond,
        borderRadius: const BorderRadius.all(Radius.circular(2.5))),
  );
}

Widget backArrow(BuildContext context) {
  return Container(
   
    decoration: BoxDecoration(
        color: colorFourth,
        borderRadius:
            const BorderRadius.only(bottomRight: Radius.circular(25))),
    width: width,
    height: height,
    child: Center(
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 30,
          height: 17,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Hero(tag: "3", child: arrowPieces(-.785, 15)),
            Hero(tag: "1", child: arrowPieces(0, 25)),
            Hero(tag: "2", child: arrowPieces(.785, 15))
          ]),
        ),
      ),
    ),
  );
}

Widget arrowPieces(double rotation, double length) {
  return Transform.rotate(
    angle: rotation,
    child: Container(
      width: length,
      height: 5,
      decoration: BoxDecoration(
          color: colorSecond,
          borderRadius: const BorderRadius.all(Radius.circular(2.5))),
    ),
  );
}

Widget home() {
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
        container(Offset(0, 10), 25, pi/2, ),
        container(Offset(0, -7), 25, pi/2, ),
        container(Offset(10, 0), 25, 0, ),
        container(Offset(-10, 0), 25, 0, ),
        container(Offset(-9, -11), 27, pi/3.5,),
        container(Offset(9, -11), 27, -pi/3.5, )
      ]),
    ),
  );
}

Widget container(Offset offset, double length, double rotation) {
  return Transform.translate(
    offset: offset,
    child: Transform.rotate(
      angle: rotation,
      child: Container(
        width: 5,
        height: length,
      decoration: BoxDecoration(
          color: colorSecond,
          borderRadius: const BorderRadius.all(Radius.circular(2.5))),
      ),
    ),
  );
}
