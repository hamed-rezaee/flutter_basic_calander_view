import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar View'),
      ),
      body: Column(
        children: [
          _buildMonthHeader(),
          _buildCalendar(),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
              });
            },
          ),
          Text(
            '${_selectedDate.year}-${_selectedDate.month}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    DateTime firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    int daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: daysInMonth + firstDayOfMonth.weekday - 1,
      itemBuilder: (context, index) {
        if (index < firstDayOfMonth.weekday - 1) {
          return Container(); // Empty space before the first day of the month
        }

        int day = index - firstDayOfMonth.weekday + 2;

        return GestureDetector(
          onTap: () {
            // Handle day selection
            print('Selected: ${_selectedDate.year}-${_selectedDate.month}-$day');
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _isSelectedDay(_selectedDate, day) ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '$day',
              style: TextStyle(
                color: _isSelectedDay(_selectedDate, day) ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isSelectedDay(DateTime selectedDate, int day) {
    return selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month &&
        day == DateTime.now().day;
  }
}

void main() {
  runApp(MaterialApp(
    home: CalendarView(),
  ));
}
