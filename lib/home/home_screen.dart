import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/firebase.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFourth,
      body: Column(children: [welcomeBanner(context), eventSection(context)]),
    );
  }
}

Widget welcomeBanner(BuildContext context) {
  double height = MediaQuery.of(context).size.height;

  return Container(
    height: height / 3,
    child: Center(
        child: Icon(
      Icons.kayaking,
      size: height / 3.2,
      color: colorSecond,
    )),
  );
}

Widget eventSection(BuildContext context) {

  return Container(
    child: Column(
      children: [
        Container(
          height: 75,
          width: double.infinity,
          color: colorThird,
          child: Center(
              child: Text(
            "Events",
            style: styleTitle,
          )),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [homeEvent(context, mockEventOne), homeEvent(context, mockEventTwo)],)
      ],
    ),
  );
}

Widget homeEvent(BuildContext context, Event event) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: Container(
      height: 200,
      width: (MediaQuery.of(context).size.width/2)-40,
        decoration:
        
            BoxDecoration(
              color: colorThird,
              borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Image.network("https://firebasestorage.googleapis.com/v0/b/qc-college-and-career.appspot.com/o/International-Mud-Day.jpg?alt=media&token=2448f50b-4176-42a5-827b-8034e5781b34"),),
              
  );
}
