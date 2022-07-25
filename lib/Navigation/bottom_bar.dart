import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/calendar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/home/home_screen.dart';

List<bool> currentPage = [true, false, false];

class BottomBar extends StatefulWidget {
  bool? popBeforeNav;
  BottomBar({Key? key, this.popBeforeNav}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "BottomBar",
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            createNavButton(context, widget.popBeforeNav, Icons.home_outlined, Icons.home_filled,
                HomeScreen(), 0),
            createNavButton(context, widget.popBeforeNav,
                Icons.calendar_month_outlined,  Icons.calendar_month, CalendarScreen(), 1),
            createNavButton(context, widget.popBeforeNav, Icons.people_outlined, Icons.people,
                HomeScreen(), 2),
          ],
        ),
      ),
    );
  }
}

Widget createNavButton(
    BuildContext context,
    bool? pop,
    IconData notActiveIconData,
    IconData activeIconData,
    Widget navigate,
    int pageNumber) {
  return TextButton(
      onPressed: () {
        currentPage = [false, false, false];
        currentPage.removeAt(pageNumber);
        currentPage.insert(pageNumber, true);

        if (pop == true) {
          Navigator.pop(context);
        }
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return navigate;
        }));
      },
      child: Icon(
        currentPage[pageNumber]? activeIconData : notActiveIconData,
        color: colorSecond,
        size: currentPage[pageNumber]? 35 : 30,
      ));
}
