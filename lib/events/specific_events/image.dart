import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';
import 'package:qc_collegeandcareer/logic/firebase.dart';

class ImageWidget extends StatefulWidget {
  ImageWidget({Key? key, required this.event, required this.image})
      : super(key: key);

  Event event;
  DecorationImage image;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${widget.event.id}image",
      child: Opacity(
        opacity: 1,
        child: Container(
          height: MediaQuery.of(context).size.width * .6,
          width: double.infinity,
          decoration: BoxDecoration(
              image: widget.image,
              color: getColorFromList(appSetup.colorMap["colorThird"]),
              borderRadius: const BorderRadius.all(Radius.circular(0))),
        ),
      ),
    );
  }
}
