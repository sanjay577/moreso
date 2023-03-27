import 'package:flutter/material.dart';

class eventPage extends StatefulWidget {
  final eventsdate, date;
  final Function(DateTime startTime, DateTime endTime) onTimeRangeSelected;

  const eventPage(
      {super.key,
      required this.eventsdate,
      required this.date,
      required this.onTimeRangeSelected});

  @override
  State<eventPage> createState() => _eventPageState();
}

class _eventPageState extends State<eventPage> {
  late DateTime _startTime;

  late DateTime _endTime;

  var a, b;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _endTime = DateTime.now();
  }

  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startTime),
    );

    if (selectedTime != null) {
      setState(() {
        _startTime = DateTime(
          _startTime.year,
          _startTime.month,
          _startTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });

      widget.onTimeRangeSelected(_startTime, _endTime);
    }
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_endTime),
    );

    if (selectedTime != null) {
      setState(() {
        _endTime = DateTime(
          _endTime.year,
          _endTime.month,
          _endTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });

      widget.onTimeRangeSelected(_startTime, _endTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: prefer_interpolation_to_compose_strings
      appBar: AppBar(title: Text("スケジュール登録画面" + widget.date)),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _selectStartTime(context),
                child: Text('Start Time'),
              ),
              Text(
                '${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 18.0),
              ),
              ElevatedButton(
                onPressed: () => _selectEndTime(context),
                child: Text('End Time'),
              ),
              Text(
                '${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 18.0),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      a = '${_endTime.hour}:${_endTime.minute.toString().padLeft(2, '0')}';
                      b = '${_startTime.hour}:${_startTime.minute.toString().padLeft(2, '0')}';
                    });
                    print('登録');
                  },
                  child: Text('登録')),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.eventsdate.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  // color: Colors.amber[colorCodes[index]],
                  child: Column(
                    children: <Widget>[
                      Text('Entry ${widget.eventsdate[index].eventname}'),
                      Row(
                        children: <Widget>[
                          a == null ? Text('') : Text('$a'),
                          b == null ? Text('') : Text('$b'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DateFormat {
  DateFormat(String s);

  format(DateTime parsedTime) {}

  static jm() {}
}
