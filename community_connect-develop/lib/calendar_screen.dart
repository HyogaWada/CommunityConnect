import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'event.dart';

Map<DateTime, List<Event>> groupEvents(List<Event> events) {
  Map<DateTime, List<Event>> groupedEvents = {};

  for (var event in events) {
    DateTime start =
        DateTime.utc(event.start.year, event.start.month, event.start.day);
    DateTime end = DateTime.utc(event.end.year, event.end.month, event.end.day);

    // 開始日から終了日までの各日にイベントを追加
    for (DateTime date = start;
        date.isBefore(end.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      if (!groupedEvents.containsKey(date)) {
        groupedEvents[date] = [];
      }
      groupedEvents[date]!.add(event);
    }
  }

  return groupedEvents;
}

class CalendarScreen extends StatefulWidget {
  final List<Event> events;

  CalendarScreen({Key? key, required this.events}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<Event>> _groupedEvents;
  late List<Event> _selectedEvents;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _groupedEvents = groupEvents(widget.events);
    _selectedEvents = [];
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  Color _getMarkerColorByIndex(int index) {
    List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('カレンダー'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            locale: 'ja_JP',
            calendarFormat: _calendarFormat,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month', // 月表示のみを許可
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents = _groupedEvents[selectedDay] ?? [];
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return _groupedEvents[day] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(events.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getMarkerColorByIndex(index),
                          ),
                          width: 7,
                          height: 7,
                        );
                      }),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                final event = _selectedEvents[index];
                return ListTile(
                  title: Text(event.name),
                  subtitle: Text('${event.place} - ${event.start.description}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
