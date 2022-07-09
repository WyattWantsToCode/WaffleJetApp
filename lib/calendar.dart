import 'package:flutter/material.dart';
import 'package:qc_collegeandcareer/day_class.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime? _selectedDay;
DateTime? _focusedDay;
var _calendarFormat = CalendarFormat.month;

class Calendar extends StatefulWidget {
  Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> _events;

  void initState() {
    super.initState();
    _events = {
      DateTime.utc(2022, 7, 9): <Event>[Event(title: "title"), Event(title: "title")]
    };
  }

  List<Event> listOfDayEvents(DateTime dateTime) {
    return _events[dateTime] ?? [];
  }

  List<Event> selectedEvent = <Event>[];
  bool showEvent = false;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        selectedEvent = listOfDayEvents(focusedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
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
              return listOfDayEvents(day);
            },
          ),
          eventDetails(selectedEvent)
        ],
      ),
    );
  }
}

Widget eventDetails(List<Event> eventList) {
  if (eventList.isEmpty) {
    return Text("Nothing today");
  } else {
    for (var event in eventList) {
      return Text(event.title);
    }
    return Text("data");
  }
}
