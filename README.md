# How can we move to specific time while switching from month to day view in Flutter event calendar (SfCalendar)?

In Flutter calendar, you can move to the specific time while switching from MonthView to any views such as DayView by using the initialDisplayDate property of calendar.

## Step 1: In initState(), set the default values for calendar.

```xml
CalendarView _calendarView;
DateTime _jumpToTime = DateTime.now();
String _text = '';
 
@override
void initState() {
      _calendarView = CalendarView.week;
      _text = DateFormat('MMMM yyyy').format(_jumpToTime).toString();
      super.initState();
}
``` 

## Step 2:
Place the calendar in the body of the Scaffold. 

```xml
body: Column(
 children: <Widget>[
  Expanded(
   child: SfCalendar(
    initialDisplayDate: _jumpToTime,
    onTap: calendarTapped,
    ),
   ), 
 ],
),
```
## Step 3:
Using the OnTap event, you can move from MonthView to the DayView of selected date with specified time.

```xml
void calendarTapped(CalendarTapDetails calendarTapDetails) {
 if (_calendarView == CalendarView.month && calendarTapDetails.targetElement == CalendarElement.calendarCell) {
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
```
