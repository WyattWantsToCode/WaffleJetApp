
import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';

Widget appBar(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IndexedStack(
        children: [
          backArrow(context),
        ],
      ),
    ],
  );
}

double width = 60;
double height = 60;



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
        child: SizedBox(
          width: 30,
          height: 17,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            arrowPieces(-.785, 15),
            arrowPieces(0, 25),
            arrowPieces(.785, 15)
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
          color: getColorFromList(appSetup.colorMap["colorSecond"]),
          borderRadius: const BorderRadius.all(Radius.circular(2.5))),
    ),
  );
}

