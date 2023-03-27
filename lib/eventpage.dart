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
  List<Map<String, String>> _timeRanges = [];

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
                      _timeRanges.add({
                        'start': DateFormat.jm().format(_startTime).toString(),
                        'end': DateFormat.jm().format(_endTime).toString(),
                      });
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
                Map<String, String> timeRange;
                if (_timeRanges[index]['start']! == null) {
                  timeRange = _timeRanges[index];
                } else {
                  timeRange = {
                    'start': _startTime.hour.toString() +
                        ':' +
                        _startTime.minute.toString().padLeft(2, '0'),
                    'end': _endTime.hour.toString() +
                        ':' +
                        _endTime.minute.toString().padLeft(2, '0')
                  };
                }

                return ListTile(
                  title: Text('${widget.eventsdate[index].eventName}}'),
                  subtitle:
                      timeRange['start'] != null && timeRange['end'] != null
                          ? Text('${timeRange['start']} - ${timeRange['end']}')
                          : null,
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteTimeRange(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _deleteTimeRange(int index) {
    setState(() {
      _timeRanges.removeAt(index);
    });
  }
}

class DateFormat {
  DateFormat(String s);

  format(DateTime parsedTime) {}

  static jm() {}
}
