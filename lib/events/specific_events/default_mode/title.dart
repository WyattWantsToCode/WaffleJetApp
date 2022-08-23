import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';

class TitleWidget extends StatelessWidget {
 TitleWidget({
    Key? key,
    required this.event
  }) : super(key: key);

  Event event;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${event.id}title",
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.75),
                  blurRadius: 15,
                  offset: const Offset(5, 5))
            ],
            color: getColorFromList(appSetup.colorMap["colorFourth"]),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36))),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
            child: Center(
              child: Text(
                event.title,
                style: styleTitle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


