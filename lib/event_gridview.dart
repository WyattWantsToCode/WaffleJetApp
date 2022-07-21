import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/specific_post/specific_event_screen.dart';
import 'package:qc_collegeandcareer/storage.dart';

Widget eventRow(BuildContext context, List<Event> list) {
  List<Widget> widgetList = <Widget>[];
  for (var event in list) {
    widgetList.add(homeEvent(context, event));
  }
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: widgetList,
  );
}

Widget homeEvent(BuildContext context, Event event) {
  double width = (MediaQuery.of(context).size.width / 2) - 40;
  double height = 200;
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
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
                    image: NetworkImage(
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
                          image: image,
                          color: colorThird,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25))),
                    ),
                  ),
                      ),
                      Hero(
                  tag: event.id + "title",
                  child: Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: colorTransparent,
                        borderRadius:
                            BorderRadius.all(Radius.circular(25))),
                    child: Center(
                        child: Material(
                      color: Colors.transparent,
                      child: Text(
                        event.title,
                        style: styleSubtitle,
                      ),
                    )),
                  ),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(color: colorThird.withOpacity(.2), shape: BoxShape.circle),),
                             Container(
                            
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(color: colorMap[event.tag], shape: BoxShape.circle),),
                          ]
                        ))
                    ]),
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          })));
}
