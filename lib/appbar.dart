import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/home/home_screen.dart';

Widget appBar(
    bool popable, BuildContext context, GlobalKey<ScaffoldState> key) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      popable ? backArrow(context) : hamburger(context, key),
      popable ? settingsIcon(context) : settingsIcon(context),
    ],
  );
}

double width = 75;
double height = 75;

Widget settingsIcon(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: colorFourth,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25))),
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
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
    width: width,
    height: height,
    child: TextButton(
      onPressed: (() {
        key.currentState!.openDrawer();
      }),
      child: Center(
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
  );
}

Widget ham() {
  return Container(
    width: 30,
    height: 5,
    decoration: BoxDecoration(
        color: colorSecond,
        borderRadius: BorderRadius.all(Radius.circular(2.5))),
  );
}

Widget backArrow(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: colorFourth,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))),
    width: width,
    height: height,
    child: TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Container(
          width: 30,
          height: 25,
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
          borderRadius: BorderRadius.all(Radius.circular(2.5))),
    ),
  );
}
