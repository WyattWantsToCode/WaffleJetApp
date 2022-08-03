import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/calendar.dart';
import 'package:qc_collegeandcareer/contact/contact_screen.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';
import 'package:qc_collegeandcareer/home/home_screen.dart';

List<bool> currentPage = [true, false, false];

// ignore: must_be_immutable
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
      child: ClipRRect(
        child: Container(
          color: getColorFromList(appSetup.colorMap["colorFourth"])
              .withOpacity(.75),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              createNavButton(context, widget.popBeforeNav, Icons.home_outlined,
                  Icons.home, const HomeScreen(), 0),
              createNavButton(
                  context,
                  widget.popBeforeNav,
                  Icons.calendar_month_outlined,
                  Icons.calendar_month,
                  const CalendarScreen(),
                  1),
              createNavButton(context, widget.popBeforeNav,
                  Icons.people_outlined, Icons.people, const ContactScreen(), 2),
            ],
          ),
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
        currentPage[pageNumber] ? activeIconData : notActiveIconData,
        color: getColorFromList(appSetup.colorMap["colorSecond"]),
        size: currentPage[pageNumber] ? 35 : 30,
        shadows: [
          Shadow(
              color: Colors.black.withOpacity(.5),
              blurRadius: 20,
              offset: const Offset(5, 5))
        ],
      ));
}
