import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/appbar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/storage.dart';

class SpecificEventScreen extends StatefulWidget {
  Event event;
  DecorationImage image;
  SpecificEventScreen({required this.event, required this.image});

  @override
  State<SpecificEventScreen> createState() => _SpecificEventScreenState();
}

class _SpecificEventScreenState extends State<SpecificEventScreen> {
  bool animated = false;
    double opacity = 0;

  @override
  Widget build(BuildContext context) {
    
    Future.delayed(Duration(milliseconds: 500), () {
      if (!animated) {
        setState(() {
          opacity = 1;
          animated = true;
        });
      }
    });

    return Scaffold(
      backgroundColor: colorFourth,
      body: SafeArea(
        child: 
            
            Column(
              children: [
                appBar(true, context, GlobalKey()),
                Column(children: [
                Hero(
                  tag: widget.event.id + "image",
                  child: Opacity(
                    opacity: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.width * .6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: widget.image,
                          color: colorThird,
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                    ),
                  ),
                ),
                Hero(
                  tag: widget.event.id + "title",
                  child: Container(
                    width: double.infinity,
                    height: 75,
                    decoration: BoxDecoration(
                        color: colorThird,
                        borderRadius: BorderRadius.all(Radius.circular(0))),
                    child: Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.title,
                              style: styleTitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Text(
                      widget.event.description,
                      style: styleBody,
                    ),
                  ),
                )
          ]),
              ],
            ),
        ),
      );
      
    
  }
}
