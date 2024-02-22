import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<dynamic>> _events;
  late List<dynamic> _selectedEvents;
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _events = {};
    _selectedEvents = [];
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();

    // Simulate fetching availability data from a database
    _fetchAvailabilityData();
  }

  void _fetchAvailabilityData() {
    // Simulate fetching availability data from a database
    // Here, we populate _events with some sample availability slots
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final day = DateTime(now.year, now.month, now.day + i);
      _events[day] = [
        '8:00 AM - 10:00 AM',
        '10:00 AM - 12:00 PM',
        '1:00 PM - 3:00 PM',
        '3:00 PM - 5:00 PM',
      ];
    }
    // Update UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents = _events[selectedDay] ?? [];
                _selectedTime = null; // Reset selected time when changing day
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              // Customize the appearance of available days
              defaultBuilder: (context, day, events) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_selectedEvents[index]),
                  onTap: () {
                    // Handle slot selection
                    _handleSlotSelection(_selectedEvents[index]);
                  },
                );
              },
            ),
          ),
          if (_selectedEvents.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Times:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _selectedEvents
                        .map<Widget>(
                          (time) => Text(
                            time,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _handleSlotSelection(String selectedSlot) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Reservation'),
          content: Text('Do you want to reserve this slot: $selectedSlot ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add your reservation logic here
                // For example, you can update a database or perform any necessary action
                print('Slot $selectedSlot reserved!');
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}

