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
          Text("イベント名"),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'イベント名',
            ),
          ),
          Text("開始時間"),
          Text(DateFormat.jm().format(_startTime)),
          ElevatedButton(
            onPressed: () => _selectStartTime(context),
            child: Text('開始時間を選択'),
          ),
          Text("終了時間"),
          Text(DateFormat.jm().format(_endTime)),
          ElevatedButton(
            onPressed: () => _selectEndTime(context),
            child: Text('終了時間を選択'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('戻る'),
          ),
          ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.eventsdate.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                // color: Colors.amber[colorCodes[index]],
                child: Center(
                    child: Text('Entry ${widget.eventsdate[index].eventname}')),
              );
            },
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
