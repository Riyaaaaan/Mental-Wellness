// firestore_methods.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/material/time.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  static final CollectionReference _diaryCollection =
      FirebaseFirestore.instance.collection('MyDiary');

  static const Uuid _uuid = Uuid();

  static final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  //* Function to add user details to Firestore
  static Future<void> addUserDetails({
    required String userId,
    required String email,
    required String username,
    required String name,
  }) async {
    try {
      final String userId = _uuid.v4();
      await _usersCollection.doc(userId).set({
        'userId': userId,
        'email': email,
        'username': username,
        'name': name,
      });
    } catch (e) {
      print('Error adding user details: $e');
    }
  }

  //* Function to add a diary entry to Firestore
  static Future<void> addDiaryEntry(String text) async {
    if (text.isNotEmpty) {
      if (text.length > 10000) {
        return Future.error('Diary entry cannot exceed 10000 characters.');
      }
      final String entryId = _uuid.v1();
      await _diaryCollection.doc(entryId).set({
        'id': entryId,
        'note': text,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  //* Function to fetch diary entries from Firestore
  static Future<List<Map<String, dynamic>>> fetchDiaryEntries() async {
    try {
      final querySnapshot =
          await _diaryCollection.orderBy('timestamp', descending: true).get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching diary entries: $e');
      return [];
    }
  }

  //* Function to delete a diary entry from Firestore
  static Future<void> deleteDiaryEntry(String docId) async {
    try {
      await _diaryCollection.doc(docId).delete();
    } catch (e) {
      print('Error deleting diary entry: $e');
    }
  }

  //* Function to update  diary entry to Firestore
  static Future<void> updateDiaryEntry(
    String docId,
    String note,
    Timestamp lastEdited,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('MyDiary').doc(docId).update({
        'note': note,
        'lastEdited': lastEdited,
      });
      return;
    } catch (e) {
      throw Exception('Failed to update entry: $e');
    }
  }

  //* Function to add Reminder to Firestore
  static Future<void> addReminder({
    required String title,
    required String about,
    required DateTime date,
    required TimeOfDay time,
  }) async {
    // Example Firestore add operation
    // Convert TimeOfDay to a format Firestore can store, e.g., HH:mm
    final String formattedTime = formatTimeOfDay(time);
    final docRef = FirebaseFirestore.instance.collection('Reminders').doc();

    await docRef.set({
      'title': title,
      'about': about,
      'date': date,
      // Assuming you have a method to format TimeOfDay to String
      'time': formattedTime,
      'timestamp': FieldValue
          .serverTimestamp(), // Optional: Add a timestamp for when the reminder was created/added
    });
  }

  // Helper method to format TimeOfDay to a String
  static String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // Change the format if needed
    return format.format(dt);
  }
}
