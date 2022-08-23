import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';

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