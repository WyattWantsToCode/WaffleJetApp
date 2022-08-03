import 'package:flutter/material.dart';

class AppSetup {
  Map<String, dynamic> homepageSetup;
  Map<String, dynamic> contactSetup;
  Map<String, dynamic> colorMap;

  AppSetup(
      {required this.homepageSetup,
      required this.contactSetup,
      required this.colorMap});
}

Color getColorFromList(List<dynamic> list) {
  return Color.fromRGBO(list[0], list[1], list[2], 1);
}

Color getColorFromTag(String tag) {
  Map<String, dynamic> map = {};
  map.addAll(appSetup.homepageSetup);
  map.addAll(appSetup.contactSetup);
  if (map.containsKey(tag)) {
    return getColorFromList(map[tag]);
  } else {
    return Colors.transparent;
  }
}

Map<String, dynamic> homepage = {
  "Events": <int>[255, 0, 0],
  "Testing": <int>[0, 255, 0]
};

Map<String, dynamic> contactSetup = {
  "Contacts": <int>[0, 0, 255],
  "Testing": <int>[0, 255, 0]
};

Map<String, dynamic> colors = {
  "colorFirst": <int>[231, 246, 242],
  "colorSecond": <int>[165, 201, 202],
  "colorThird": <int>[57, 91, 100],
  "colorFourth": <int>[44, 51, 51]
};

AppSetup appSetup = AppSetup(
    homepageSetup: homepage, contactSetup: contactSetup, colorMap: colors);