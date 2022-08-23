import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';

class TagWidget extends StatelessWidget {
  final Event event;
  const TagWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "${event.id}tag",
        child: Container(
          width: double.infinity,
          height: 7,
          color: getColorFromTag(event.tag),
        ));
  }
}
