import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/Navigation/bottom_bar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/events//event_card.dart';

import 'package:qc_collegeandcareer/logic/firebase.dart';

import 'package:qc_collegeandcareer/events/specific_event_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientBackground(color: colorAccentSecond),
        Scaffold(
            backgroundColor: getColorFromList(appSetup.colorMap["colorThird"])
                .withOpacity(.3),
            key: globalKey,
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: FutureBuilder(
                          future: getAllEventsFromDB(),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Error"),
                                );
                              } else if (snapshot.hasData) {
                                return Calendar(
                                  eventMap: getAllEventMap(
                                      snapshot.data as List<Event>),
                                );
                              }
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  BottomBar()
                ],
              ),
            )),
      ],
    );
  }
}

DateTime? _selectedDay;
DateTime _focusedDay = DateTime.now();
var _calendarFormat = CalendarFormat.month;
List<Event> selectedEvent = <Event>[];

class Calendar extends StatefulWidget {
  const Calendar({Key? key, required this.eventMap}) : super(key: key);

  final Map<DateTime, List<Event>> eventMap;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Event> listOfDayEvents(DateTime dateTime) {
    return widget.eventMap[dateTime] ?? [];
  }

  bool showEvent = false;
  // ignore: prefer_typing_uninitialized_variables
  var markerEvent;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = selectedDay;
        _selectedDay = selectedDay;
        selectedEvent = listOfDayEvents(focusedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.8),
                      blurRadius: 25,
                      offset: const Offset(5, 5))
                ],
                color: getColorFromList(appSetup.colorMap["colorFourth"]),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36))),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: TableCalendar(
                shouldFillViewport:
                    (_calendarFormat == CalendarFormat.month) ? false : false,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  onDaySelected(selectedDay, focusedDay);
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                eventLoader: (day) {
                  markerEvent = day;
                  return listOfDayEvents(day);
                },
                calendarStyle: calendarStyle(),
                headerStyle: headerStyle(),
                daysOfWeekStyle: daysOfWeekStyle(),
                daysOfWeekHeight: 40,
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isEmpty) return const SizedBox();
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          Event currentEvent = events[index] as Event;
                          return Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: getColorFromTag(currentEvent.tag),
                                    shape: BoxShape.circle),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            )),
        eventWrap(context, selectedEvent)
      ],
    );
  }
}

Widget eventWrap(BuildContext context, List<Event> list) {
  List<Widget> widgetList = <Widget>[];
  for (var event in list) {
    widgetList.add(eventCard(context, event, getColorFromTag(event.tag)));
  }
  return Wrap(
    children: widgetList,
  );
}

CalendarStyle calendarStyle() {
  double fontOffset = 3;
  return CalendarStyle(
    defaultTextStyle: styleBody.apply(fontSizeDelta: fontOffset),
    todayTextStyle: styleBody.apply(fontSizeDelta: fontOffset),
    disabledTextStyle: styleBody.apply(fontSizeDelta: fontOffset),
    selectedTextStyle: styleBody.apply(fontSizeDelta: fontOffset),
    weekendTextStyle: styleBody.apply(fontSizeDelta: fontOffset),
    outsideTextStyle: styleBody.apply(
        fontSizeDelta: 0,
        color:
            getColorFromList(appSetup.colorMap["colorSecond"]).withOpacity(.6)),
    cellMargin: const EdgeInsets.all(0),
    cellPadding: const EdgeInsets.all(10),
    selectedDecoration: BoxDecoration(
        color:
            getColorFromList(appSetup.colorMap["colorSecond"]).withOpacity(.6),
        shape: BoxShape.circle),
    todayDecoration:
        BoxDecoration(color: colorTransparent, shape: BoxShape.circle),
  );
}

HeaderStyle headerStyle() {
  return HeaderStyle(
      titleTextStyle: styleSubtitle,
      titleCentered: true,
      leftChevronIcon: Icon(
        Icons.chevron_left_rounded,
        color: getColorFromList(appSetup.colorMap["colorSecond"]),
        size: 40,
      ),
      rightChevronIcon: Icon(
        Icons.chevron_right_rounded,
        color: getColorFromList(appSetup.colorMap["colorSecond"]),
        size: 40,
      ),
      formatButtonVisible: false,
      formatButtonShowsNext: false,
      formatButtonTextStyle: styleBody,
      formatButtonDecoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(
            color: getColorFromList(appSetup.colorMap["colorSecond"]),
          )),
          borderRadius: const BorderRadius.all(Radius.circular(12.0))));
}

DaysOfWeekStyle daysOfWeekStyle() {
  return DaysOfWeekStyle(
    weekdayStyle: styleBody,
    weekendStyle: styleBody,
  );
}
