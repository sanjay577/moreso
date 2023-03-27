import 'package:flutter/material.dart';

class eventPage extends StatelessWidget {
  final eventsdate, date;

  const eventPage({super.key, required this.eventsdate, required this.date});

  get timeinput => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // ignore: prefer_interpolation_to_compose_strings
        appBar: AppBar(title: Text("スケジュール登録画面" + date)),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: eventsdate.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                  height: 50,
                  child: TextField(
                      controller:
                          timeinput, //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.timer), //icon of text field
                          labelText: "Enter Time" //label text of field
                          ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                        if (pickedTime != null) {
                          print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime =
                              DateFormat('HH:mm:ss').format(parsedTime);
                          print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                          setState(() {
                            timeinput.text =
                                formattedTime; //set the value of text field.
                          });
                        } else {
                          print("Time is not selected");
                        }
                      }));
            }));
  }

  void setState(Null Function() param0) {}
}

class DateFormat {
  DateFormat(String s);

  format(DateTime parsedTime) {}

  static jm() {}
}
