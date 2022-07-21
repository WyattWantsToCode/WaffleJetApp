import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qc_collegeandcareer/appbar.dart';
import 'package:qc_collegeandcareer/color_pallet.dart';
import 'package:qc_collegeandcareer/events/event_gridview.dart';

import 'package:qc_collegeandcareer/firebase.dart';
import 'package:qc_collegeandcareer/navigation_drawer.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorFourth,
        key: globalKey,
        drawer: drawer(context),
        body: SafeArea(
          child: Stack(
            children: [
              
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 75,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: FutureBuilder(
                        future: getAllEventsFromDB(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Error"),
                              );
                            } else if (snapshot.hasData) {
                              return Calendar(
                                eventMap: getAllEventMap(snapshot.data as List<Event>),
                              );
                            }
                          }
                            
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              appBar(false, context, globalKey),
              
               
            ],
          ),
        ));
  }
}

DateTime? _selectedDay;
DateTime _focusedDay = DateTime.now();
var _calendarFormat = CalendarFormat.month;
List<Event> selectedEvent = <Event>[];

class Calendar extends StatefulWidget {
  Calendar({Key? key, required this.eventMap}) : super(key: key);

  final Map<DateTime, List<Event>> eventMap;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Event> listOfDayEvents(DateTime dateTime) {
    return widget.eventMap[dateTime] ?? [];
  }

  
  bool showEvent = false;
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
            
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TableCalendar(
                shouldFillViewport: (_calendarFormat == CalendarFormat.month)? false : false,
                
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
                
                if (events.isEmpty) return SizedBox();
                return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      Event currentEvent = events[index] as Event;
                      return Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: colorMap[currentEvent.tag],
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

CalendarStyle calendarStyle() {
  return CalendarStyle(
    defaultTextStyle: styleSubtitle,
    todayTextStyle: styleSubtitle,
    disabledTextStyle: styleSubtitle,
    selectedTextStyle: styleSubtitle,
    weekendTextStyle: styleSubtitle,
    outsideTextStyle: styleSubtitle.apply(fontSizeDelta: -5, color: colorSecond.withOpacity(.6)),
    
    cellMargin: EdgeInsets.all(0),
    cellPadding: EdgeInsets.all(10),
    selectedDecoration: BoxDecoration(
        color: colorSecond.withOpacity(.6), shape: BoxShape.circle),
    todayDecoration:
        BoxDecoration(color: colorTransparent, shape: BoxShape.circle),
  );
}

HeaderStyle headerStyle() {
  return HeaderStyle(
      titleTextStyle: styleSubtitle,
      leftChevronIcon: Icon(
        Icons.chevron_left_rounded,
        color: colorSecond,
        size: 40,
      ),
      rightChevronIcon: Icon(
        Icons.chevron_right_rounded,
        color: colorSecond,
        size: 40,
      ),
      formatButtonShowsNext: false,
      formatButtonTextStyle: styleBody,
      formatButtonDecoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(
            color: colorSecond,
          )),
          borderRadius: const BorderRadius.all(Radius.circular(12.0))));
}

DaysOfWeekStyle daysOfWeekStyle() {
  return DaysOfWeekStyle(
    
    weekdayStyle: styleBody,
    weekendStyle: styleBody,
    
  );
}
