import 'package:flutter/material.dart';

class ReminderModel {
  String title;
  String about;
  DateTime date;
  TimeOfDay time;

  ReminderModel(
      {required this.title,
      required this.about,
      required this.date,
      required this.time});

  // Convert a ReminderModel instance into a Map. The keys must correspond to the names of the
  // fields in your Firestore collection.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'about': about,
      'date': date,
      'time': '${time.hour}:${time.minute}',
    };
  }
}
