import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mental_wellness/screens/dashboard/dash_board.dart';
import '../firebase/firestore_methods.dart'; // Adjust the import as necessary

class ReminderPage extends StatefulWidget {
  final String title;
  final String about;
  const ReminderPage({Key? key, required this.title, required this.about})
      : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Date & Time')),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                  style: const TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Selected Time: ${_selectedTime.format(context)}',
                  style: const TextStyle(fontSize: 18)),
            ),
            CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) =>
                  setState(() => _selectedDate = date),
              thisMonthDayBorderColor: Colors.grey,
              weekFormat: false,
              height: 400.0,
              selectedDateTime: _selectedDate,
              customGridViewPhysics: const NeverScrollableScrollPhysics(),
              markedDateShowIcon: true,
              markedDateIconMaxShown: 2,
              markedDateMoreShowTotal: false,
              showHeader: false,
              selectedDayTextStyle: const TextStyle(color: Colors.white),
              todayTextStyle: const TextStyle(color: Colors.blue),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: _selectDate, child: const Text('Pick Date')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: _selectTime, child: const Text('Pick Time')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await FirestoreMethods.addReminder(
                    title: widget.title,
                    about: widget.about,
                    date: _selectedDate,
                    time: _selectedTime,
                  );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const DashBoardPage(),
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(double.infinity, 48)),
                child: const Text('Set Reminder'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
