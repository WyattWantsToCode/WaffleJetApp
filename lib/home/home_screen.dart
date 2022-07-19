import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/create_events/create_event_screen.dart';
import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorFourth,
      body: Column(children: [
        welcomeBanner(context),
        eventSection(context),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateEventScreen();
              }));
            },
            child: Text("Event Create"))
      ]),
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
          children: [
            homeEvent(context, mockEventOne),
            homeEvent(context, mockEventTwo)
          ],
        )
      ],
    ),
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
                return Stack(alignment: Alignment.bottomCenter, children: [
                  Opacity(
                    opacity: .75,
                    child: Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                snapshot.data as String,
                              ),
                              fit: BoxFit.cover),
                          color: colorThird,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                  ),
                  Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: colorTransparent,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Center(
                        child: Text(
                      event.title,
                      style: styleSubtitle,
                    )),
                  )
                ]);
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          })));
}
