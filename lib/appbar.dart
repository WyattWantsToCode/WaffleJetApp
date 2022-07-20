import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';

Widget appBar(bool popable) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        popable? Text("data") : hamburger(),
        Icon(Icons.settings, color: colorSecond, size: 30,)
      ],
    ),
  );
}

Widget hamburger() {
  return Container(
    height: 25,
    width: 30,
    child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ham(), ham(), ham()]),
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
