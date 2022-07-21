import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/appbar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/create_events/create_event_screen.dart';
import 'package:qc_collegeandcareer/events/event_gridview.dart';

import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/navigation_drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      drawer: drawer(context),
      backgroundColor: colorFourth,
      body: SafeArea(
        child: Stack(alignment: Alignment.topCenter, children: [
          SingleChildScrollView(
            child: Column(children: [
              welcomeBanner(context),
              eventSection(context),
              ElevatedButton(
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
                  child: Text("Place"))
            ]),
          ),
          appBar(false, context, globalKey)
        ]),
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
                  widgetList.add(eventCard(context, event));
                }

                return Wrap(
                  
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

