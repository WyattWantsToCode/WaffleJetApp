import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';

class TagWidget extends StatefulWidget {
  final Event event;
  const TagWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<TagWidget> createState() => _TagWidgetState();
}

class _TagWidgetState extends State<TagWidget> {
  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "${widget.event.id}tag",
        child: Container(
          width: double.infinity,
          height: 7,
          color: colorMap[widget.event.tag],
        ));
  }
}
