import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/specific_post/specific_event_screen.dart';
import 'package:qc_collegeandcareer/storage.dart';

Widget eventWrap(BuildContext context, List<Event> list) {
  List<Widget> widgetList = <Widget>[];
  for (var event in list) {
    widgetList.add(eventCard(context, event, getColorFromTag(event.tag)));
  }
  return Wrap(
    children: widgetList,
  );
}

Widget eventCard(BuildContext context, Event event, Color tagColor) {
  double sectionsWidth = 300;
  double width = (MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.width / sectionsWidth).round()) -
      40;
  double height = 200;
  return Container(
    child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
        child: FutureBuilder(
            future: getImageURL(event),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                } else if (snapshot.hasData) {
                  var imageString = snapshot.data as String;
                  DecorationImage image = DecorationImage(
                      image: CachedNetworkImageProvider(
                        imageString,
                      ),
                      fit: BoxFit.cover);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SpecificEventScreen(event: event, image: image);
                      }));
                    },
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Hero(
                        tag: event.id + "image",
                        child: Opacity(
                          opacity: .75,
                          child: Container(
                            height: height,
                            width: width,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.75),
                                      blurRadius: 15,
                                      offset: Offset(7, 7))
                                ],
                                image: image,
                                color: getColorFromList(
                                    appSetup.colorMap["colorFourth"]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                          ),
                        ),
                      ),
                      Hero(
                        tag: event.id + "title",
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5.0,
                              sigmaY: 5.0,
                            ),
                            child: Container(
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: getColorFromList(
                                          appSetup.colorMap["colorFourth"])
                                      .withOpacity(.85),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              child: Center(
                                  child: Material(
                                color: Colors.transparent,
                                child: AutoSizeText(
                                  event.title,
                                  style: styleSubtitle,
                                  maxLines: 1,
                                ),
                              )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 5,
                          left: 5,
                          child: Stack(alignment: Alignment.center, children: [
                            ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 1.0,
                                  sigmaY: 1.0,
                                ),
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      gradient: RadialGradient(colors: [
                                        getColorFromList(appSetup.colorMap["colorThird"]),
                                        getColorFromList(appSetup.colorMap["colorThird"]).withOpacity(.2)
                                      ]),
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ),
                            Hero(
                              tag: event.id + "tag",
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                    color: tagColor,
                                    shape: BoxShape.circle),
                              ),
                            ),
                          ]))
                    ]),
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }))),
  );
}
