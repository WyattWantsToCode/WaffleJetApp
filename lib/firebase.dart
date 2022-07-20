import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

Event mockEventOne = Event(
    id: "1",
    title: "Crew night",
    startTime: DateTime.utc(2022, 7, 17),
    description: "description",
    tag: "Tag1");
Event mockEventTwo = Event(
    id: "2",
    title: "Fun n' Mud",
    startTime: DateTime.utc(2022, 7, 18),
    description: "2 description",
    tag: "Tag2");

class Event {
  String id;
  String title;
  DateTime startTime;
  String description;
  String tag;

  Event(
      {required this.id,
      required this.title,
      required this.startTime,
      required this.description,
      required this.tag});
}

Map<String, dynamic> eventToMap(Event event) {
 

  return {
    "id": event.id,
    "title": event.title,
    "startTime": Timestamp.fromDate(event.startTime),
    "description": event.description,
    "tag": event.tag
  };
}

Event mapToEvent(Map<String, dynamic> map) {

  return Event(
      id: map["id"],
      title: map["title"],
      startTime: DateTime.fromMicrosecondsSinceEpoch(map["startTime"].microsecondsSinceEpoch),
      description: map["description"],
      tag: map["tag"]);
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
