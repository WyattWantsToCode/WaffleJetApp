import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/Navigation/bottom_bar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';

import 'package:qc_collegeandcareer/events/event_card.dart';
import 'package:qc_collegeandcareer/logic/appsetup.dart';

import 'package:qc_collegeandcareer/logic/firebase.dart';

import 'package:qc_collegeandcareer/events/specific_events/specific_event_screen.dart';
import 'package:qc_collegeandcareer/logic/storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> sections = <Widget>[];

    appSetup.homepageSetup.forEach(((key, value) {
      sections.add(homeScreenSectionBuilder(context, key));
    }));
    return Stack(
      children: [
        GradientBackground(color: colorAccentSecond),
        Scaffold(
          key: globalKey,
          backgroundColor:
              getColorFromList(appSetup.colorMap["colorThird"]).withOpacity(.3),
          body: SafeArea(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: Column(
                            children: [welcomeBanner(context), ...sections]),
                      ),
                    ),
                  ),
                  BottomBar(),
                ]),
          ),
        ),
      ],
    );
  }
}

Widget welcomeBanner(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  return FutureBuilder(
    future: getLogoURL(),
    builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        } else if (snapshot.hasData) {
          return GestureDetector(
            onLongPress: () {
               editMode = true;
            },
            child: SizedBox(
                height: height / 3,
                child: Center(
                    child: CachedNetworkImage(
                  imageUrl: snapshot.data as String,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ))),
          );
        }
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    }),
  );
}

Widget homeScreenSectionBuilder(BuildContext context, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Column(
      children: [
        Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            color: getColorFromList(appSetup.colorMap["colorFourth"]),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.75),
                  blurRadius: 15,
                  offset: const Offset(7, 7))
            ],
          ),
          child: Center(
              child: Text(
            label,
            style: styleTitle,
          )),
        ),
        Container(
          width: double.infinity,
          height: 7,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: getColorFromTag(label)),
        ),
        futureCardBuilder(context, label)
      ],
    ),
  );
}

Widget futureCardBuilder(BuildContext context, String tag) {
  return FutureBuilder(
    future: getEventsByTag(tag),
    builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        } else if (snapshot.hasData) {
          List<Widget> widgetList = <Widget>[];

          for (var event in snapshot.data as List<Event>) {
            widgetList
                .add(eventCard(context, event, getColorFromTag(event.tag)));
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
  );
}
