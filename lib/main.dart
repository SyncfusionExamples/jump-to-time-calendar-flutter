import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<MyApp> {
  CalendarView _calendarView;
  DateTime _jumpToTime = DateTime.now();
  String _text = '';
  Color headerColor, viewHeaderColor, calendarColor, defaultColor;

  @override
  void initState() {
    _calendarView = CalendarView.month;
    _text = DateFormat('MMMM yyyy').format(_jumpToTime).toString();
    super.initState();
  }

  List<String> colors = <String>[
    'Pink',
    'Blue',
    'Yellow',
    'Wall Brown',
    'Default'
  ];

  List<String> views = <String>[
    'Day',
    'Month',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(Icons.color_lens),
              itemBuilder: (BuildContext context) =>
                  colors.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice, child: Text(choice));
              }).toList(),
              onSelected: (String value) {
                setState(() {
                  if (value == 'Pink') {
                    headerColor = const Color(0xFF09e8189);
                    viewHeaderColor = const Color(0xFF0f3acb6);
                    calendarColor = const Color(0xFF0ffe5d8);
                  } else if (value == 'Blue') {
                    headerColor = const Color(0xFF0007eff);
                    viewHeaderColor = const Color(0xFF03aa4f6);
                    calendarColor = const Color(0xFF0bae5ff);
                  } else if (value == 'Wall Brown') {
                    headerColor = const Color(0xFF0937c5d);
                    viewHeaderColor = const Color(0xFF0e6d9b1);
                    calendarColor = const Color(0xFF0d1d2d6);
                  } else if (value == 'Yellow') {
                    headerColor = const Color(0xFF0f7ed53);
                    viewHeaderColor = const Color(0xFF0fff77f);
                    calendarColor = const Color(0xFF0f7f2cc);
                  } else if (value == 'Default') {
                    headerColor = null;
                    viewHeaderColor = null;
                    calendarColor = null;
                  }
                });
              },
            ),
          ],
          backgroundColor: headerColor,
          //Color(0xFF003264),
          centerTitle: true,
          titleSpacing: 60,
          title: Text(_text),
          leading: PopupMenuButton<String>(
            icon: Icon(Icons.calendar_today),
            itemBuilder: (BuildContext context) => views.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList(),
            onSelected: (String value) {
              setState(() {
                if (value == 'Day') {
                  _calendarView = CalendarView.day;
                } else if (value == 'Month') {
                  _calendarView = CalendarView.month;
                }
              });
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: SfCalendar(view: _calendarView,
                initialDisplayDate: _jumpToTime,
                onTap: calendarTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (_calendarView == CalendarView.month &&
        calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      _calendarView = CalendarView.day;
      _updateState(calendarTapDetails.date);
    }
  }

  void _updateState(DateTime date) {
    setState(() {
      _jumpToTime = date.add(const Duration(hours: 3, minutes: 30));
      _text = DateFormat('MMMM yyyy').format(_jumpToTime).toString();
    });
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Meeting',
      color: Colors.pink,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 4)),
      endTime: DateTime.now().add(const Duration(hours: 5)),
      subject: 'Release Meeting',
      color: Colors.lightBlueAccent,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 6)),
      endTime: DateTime.now().add(const Duration(hours: 7)),
      subject: 'Performance check',
      color: Colors.amber,
    ));
    appointments.add(Appointment(
      startTime: DateTime(2020, 1, 22, 1, 0, 0),
      endTime: DateTime(2020, 1, 22, 3, 0, 0),
      subject: 'Support',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime(2020, 1, 24, 3, 0, 0),
      endTime: DateTime(2020, 1, 24, 4, 0, 0),
      subject: 'Retrospective',
      color: Colors.purple,
    ));

    return _DataSource(appointments);
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
