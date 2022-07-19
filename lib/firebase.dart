import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

Event mockEventOne = Event(
    id: "id",
    title: "Crew night",
    startTime: DateTime.utc(2022, 7, 17),
    description: "description");
Event mockEventTwo = Event(
    id: "2 id",
    title: "Fun n' Mud",
    startTime: DateTime.utc(2022, 7, 18),
    description: "2 description");

class Event {
  String id;
  String title;
  DateTime startTime;
  String description;

  Event(
      {required this.id,
      required this.title,
      required this.startTime,
      required this.description});
}

Map<String, dynamic> eventToMap(Event event) {
  return {
    "id": event.id,
    "title": event.title,
    "startTime": event.startTime,
    "description": event.description
  };
}

Event mapToEvent(Map<String, dynamic> map) {
  return Event(
      id: map["id"],
      title: map["title"],
      startTime: map["startTime"],
      description: map["description"]);
}

void addEventToFirestore(Event event) {
  db.collection("Events").doc(event.id).set((eventToMap(event)));
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
