import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locationtest_v2/pages/homepage.dart';
import 'package:locationtest_v2/utils/model/Task.dart';
import 'package:table_calendar/table_calendar.dart';
import '../funcs/navbar.dart';
import 'calendarEvent.dart';

class CalendarShiftWA extends StatefulWidget {
  @override
  _CalendarShiftWAState createState() => new _CalendarShiftWAState();
}

class _CalendarShiftWAState extends State<CalendarShiftWA> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _nameController;
  TextEditingController _maxWorkerAmountController;
  TextEditingController _startTimeController;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedEvents = [];
    _controller = CalendarController();
    _nameController = TextEditingController();
    _maxWorkerAmountController = TextEditingController();
    _startTimeController = TextEditingController();
    _events = {};
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Kalender-Schich-Werkarbeit'),
      ),
      drawer: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
              ),
              builders: CalendarBuilders(),
              calendarController: _controller,
              onDaySelected: (date, events) {
                setState(() {
                  _selectedEvents = events;
                });
              },
            ),
            ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CalendarEvent())),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  _showAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Schicht erstellen"),
              content: Column(
                children: <Widget>[
                  TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Name der Schichtarbeit",
                      )),
                  TextField(
                    controller: _maxWorkerAmountController,
                    decoration: InputDecoration(
                      labelText: "Anzahl der Arbeiter",
                    ),
                  ),
                  FlatButton(
                    child: Text("Startzeit einstellen"),
                    onPressed: (){

                    },
                  ),
                  FlatButton(
                    child: Text("Endzeit einstellen"),
                      onPressed: (){

                      }
                  )
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_nameController.text.isEmpty) return;
                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_nameController.text);
                      } else {
                        _events[_controller.selectedDay] = [
                          _nameController.text
                        ];
                      }
                      _nameController.clear();
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ));
  }
}
