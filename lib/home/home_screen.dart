import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/appbar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/create_events/create_event_screen.dart';
import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/specific_post/specific_event_screen.dart';
import 'package:qc_collegeandcareer/storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: colorFourth,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children:[
            appBar(false, context)
            ,
          
           SingleChildScrollView(
            child: Column(children: [
              welcomeBanner(context),
              eventSection(context),
              /*ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return CreateEventScreen();
                    }));
                  },
                  child: Text("Event Create")),
              ElevatedButton(
                  onPressed: () {
                    addEventToFirestore(mockEventOne);
                  },
                  child: Text("Place"))*/
            ]),
          ),]
        ),
      ),
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
        FutureBuilder(
          future: getEventsByTag("event"),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error"),
                );
              } else if (snapshot.hasData) {
                List<Widget> widgetList = <Widget>[];

                for (var event in snapshot.data as List<Event>) {
                  widgetList.add(homeEvent(context, event));
                }

                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widgetList,
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        )
      ],
    ),
  );
}

String imageString = "";

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
                imageString = snapshot.data as String;
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
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        child: Center(
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                event.title,
                                style: styleSubtitle,
                              ),
                            )),
                      ),
                    )
                  ]),
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          })));
}
