import 'package:flutter/material.dart';

Color colorFirst = Color.fromRGBO(231, 246, 242, 1);
Color colorSecond = Color.fromRGBO(165, 201, 202, 1);
Color colorThird = Color.fromRGBO(57, 91, 100, 1);
Color colorFourth = Color.fromRGBO(44, 51, 51, 1);

Color colorAccent = Color.fromRGBO(92, 68, 152, 50);
Color colorAccentSecond = Color.fromRGBO(96, 68, 52, 50);

Color colorTransparent = Color.fromRGBO(57, 91, 100, 50);

Map<String, Color> colorMap = {
  "event": Colors.yellow.withOpacity(.75),
  "special": Colors.blue.withOpacity(.75),
  "service project": Colors.blue.withOpacity(.75)
};

TextStyle styleTitle = TextStyle(color: colorFirst, fontSize: 48);
TextStyle styleSubtitle = TextStyle(color: colorFirst, fontSize: 24);
TextStyle styleBody = TextStyle(color: colorFirst, fontSize: 18);
