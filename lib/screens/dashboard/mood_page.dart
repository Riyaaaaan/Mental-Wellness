import 'package:flutter/material.dart';

class MoodTrackerPage extends StatefulWidget {
  const MoodTrackerPage({super.key});

  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  final List<String> _moods = ['Happy', 'Sad', 'Anxious', 'Excited', 'Calm'];
  String _selectedMood = 'Happy';
  double _intensity = 0;
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: const Text('My Mood Tracker'),
      ),
      body: Column(
        children: <Widget>[
          DropdownButton<String>(
            value: _selectedMood,
            onChanged: (String? newValue) {
              setState(() {
                _selectedMood = newValue!;
              });
            },
            items: _moods.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Slider(
            value: _intensity,
            min: 0,
            max: 100,
            divisions: 5,
            label: _intensity.round().toString(),
            onChanged: (double value) {
              setState(() {
                _intensity = value;
              });
            },
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
                labelText: 'How are you feeling today?',
              ),
              onChanged: (text) {
                _notes = text;
              },
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              // Here you can save or process the data
              print(
                  'Mood: $_selectedMood, Intensity: $_intensity, Notes: $_notes');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
