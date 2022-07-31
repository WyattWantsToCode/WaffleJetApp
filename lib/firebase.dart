import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var db = FirebaseFirestore.instance;

Event mockEventOne = Event(
  id: "no image yet.jpg",
  title: "Crew night",
  startTime: DateTime.utc(2022, 7, 17, 0, 0),
  description: "description",
  tag: "Tag1",
);
Event mockEventTwo = Event(
    id: "2",
    title: "Fun n' Mud",
    startTime: DateTime.utc(2022, 7, 18),
    description: "2 description",
    tag: "Tag2");

class Event {
  String id;
  String title;
  DateTime? startTime;
  String description;
  String tag;

  Event({
    required this.id,
    required this.title,
    required this.startTime,
    required this.description,
    required this.tag,
  });
}

Event mapToEvent(Map<String, dynamic> map) {
  DateTime? time;
  if (map.containsKey("startTime")) {
    time = DateTime.fromMicrosecondsSinceEpoch(
        map["startTime"].microsecondsSinceEpoch);
  }
  return Event(
    id: map["id"],
    title: map["title"],
    startTime: time,
    description: map["description"],
    tag: map["tag"],
  );
}

Future<List<Event>> getAllEventsFromDB() async {
  List<Event> list = <Event>[];
  await db.collection("Events").get().then((value) {
    for (var doc in value.docs) {
      list.add(mapToEvent(doc.data()));
    }
  });
  return list;
}

Future<List<Event>> getEventsByTag(String tag) async {
  List<Event> list = <Event>[];

  await db
      .collection("Events")
      .where("tag", isEqualTo: tag)
      .get()
      .then((value) {
    for (var doc in value.docs) {
      list.add(mapToEvent(doc.data()));
    }
  });

  return list;
}

Map<DateTime, List<Event>> getAllEventMap(List<Event> allEventList) {
  Map<DateTime, List<Event>> map = {
    DateTime.utc(2014, 7, 12): <Event>[mockEventOne]
  };
  for (var event in allEventList) {
    if (event.startTime != null) {
      DateTime dateTime = DateTime.utc(
          event.startTime!.year, event.startTime!.month, event.startTime!.day);
      List<Event> list = <Event>[];
      list.add(event);

      if (map.containsKey(dateTime)) {
        list = map[dateTime] as List<Event>;
        list.add(event);
        map.update(dateTime, (value) {
          return list;
        });
      } else {
        map.addAll({dateTime: list});
      }
    }
  }
  return map;
}

class AppSetup {
  Map<String, dynamic> homepageSetup;
  Map<String, dynamic> contactSetup;
  Map<String, dynamic> colorMap;

  AppSetup(
      {required this.homepageSetup,
      required this.contactSetup,
      required this.colorMap});
}

Color getColorFromList(List<int> list) {
  return Color.fromRGBO(list[0], list[1], list[2], 1);
}

Map<String, dynamic> homepage = {
  "Event": <int>[255, 0, 0, 1],
  "Testing": <int>[0, 255, 0, 1]
};

Map<String, dynamic> contactSetup = {
  "Contacts": <int>[0, 0, 255, 1],
  "Testing": <int>[0, 255, 0, 1]
};

Map<String, dynamic> colors = {
  "colorFirst": <int>[231, 246, 242,1],
  "colorSecond": <int>[165, 201, 202,1],
  "colorThird": <int>[57, 91, 100,1],
  "colorFourth": <int>[44, 51, 51,1]
};

AppSetup appSetup = AppSetup(
    homepageSetup: homepage, contactSetup: contactSetup, colorMap: colors);
