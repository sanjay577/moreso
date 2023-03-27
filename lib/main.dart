import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:moreso/eventpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TableCalendar Example',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<CalendarEvent> events = [
    CalendarEvent(
      eventName: "瞑想",
      eventDate: DateTime(
        2023,
        3,
        15,
      ),
    ),
    CalendarEvent(
      eventName: "勉強する",
      eventDate: DateTime(2023, 3, 20, 10, 1, 2),
    ),
    CalendarEvent(
      eventName: "エクササイズ",
      eventDate: DateTime(2023, 3, 20, 9, 1, 2),
    ),
    CalendarEvent(
      eventName: "休み",
      eventDate: DateTime(2023, 4, 12),
    )
  ];
  @override
  Widget build(BuildContext context) {
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("カレンダー"),
        backgroundColor: Color.fromARGB(255, 241, 234, 234),
      ),
      body: CellCalendar(
        events: events,
        cellCalendarPageController: cellCalendarPageController,
        daysOfTheWeekBuilder: (dayIndex) {
          /// dayIndex: 0 for Sunday, 6 for Saturday.
          final labels = ["日", "月", "火", "水", "木", "金", "土"];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[dayIndex],
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 212, 12, 12)),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          print(datetime);
          final year = datetime?.year.toString();
          final month = datetime?.month.toString();
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$year年 $month 月",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_back)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_forward))
                ],
              ));
        },
        onCellTapped: (date) {
          final eventsOnTheDate = events.where((event) {
            final eventDate = event.eventDate;
            return eventDate.year == date.year &&
                eventDate.month == date.month &&
                eventDate.day == date.day;
            // eventDate.hour == date.hour &&
            // eventDate.minute == date.minute;
          }).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => eventPage(
                eventsdate: eventsOnTheDate,
                date: date.month.monthName +
                    " " +
                    date.day.toString() +
                    " " +
                    date.year.toString(),
                onTimeRangeSelected: (startTime, endTime) => print(
                  "Selected time range: $startTime - $endTime",
                ),
              ),
            ),
          );
          // showDialog(
          //     context: context,
          //     builder: (_) => AlertDialog(
          //           title:
          //               Text(date.month.monthName + " " + date.day.toString()),
          //           content: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: eventsOnTheDate
          //                 .map(
          //                   (event) => Container(
          //                     width: double.infinity,
          //                     padding: EdgeInsets.all(4),
          //                     margin: EdgeInsets.only(bottom: 12),
          //                     color: event.eventBackgroundColor,
          //                     child: Text(
          //                       event.eventName,
          //                       style: TextStyle(color: event.eventTextColor),
          //                     ),
          //                   ),
          //                 )
          //                 .toList(),
          //           ),
          //         ));
        },
        onPageChanged: (firstDate, lastDate) {},
      ),
    );
  }
}
