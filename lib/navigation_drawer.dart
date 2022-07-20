import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/home/home_screen.dart';

Drawer drawer(BuildContext context) {
  List<String> list = <String>["Home", "Calendar", "Connect"];
  List<Widget> widgetList = <Widget>[HomeScreen()];

  return Drawer(
    backgroundColor: colorThird,
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListView.separated(
          itemCount: list.length,
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2,
              color: colorSecond,
            );
          },
          itemBuilder: (context, index) {
            return TextButton(
              onPressed: (() {
                Navigator.pop(context);
                
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return widgetList[index];
                }));
              }),
              child: Container(
                alignment: Alignment.centerLeft,
                height: 75,
                width: 300,
                child: Text(
                  list[index],
                  style: styleSubtitle,
                ),
              ),
            );
          }),
    ),
  );
}
