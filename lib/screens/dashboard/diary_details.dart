import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../firebase/firestore_methods.dart';

class DiaryEntryDetails extends StatefulWidget {
  final Map<String, dynamic> diaryEntry;

  const DiaryEntryDetails({Key? key, required this.diaryEntry})
      : super(key: key);

  @override
  _DiaryEntryDetailsState createState() => _DiaryEntryDetailsState();
}

class _DiaryEntryDetailsState extends State<DiaryEntryDetails> {
  late TextEditingController _noteController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.diaryEntry['note']);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _toggleEditSave() async {
    final now = Timestamp.now(); // Current timestamp for last edit
    if (_isEditing) {
      try {
        await FirestoreMethods.updateDiaryEntry(
            widget.diaryEntry['id'], _noteController.text, now);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entry updated successfully')),
        );
        // Optionally pop back to the previous screen after delay
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Formatting the creation date and time into one field
    final timestamp = widget.diaryEntry['timestamp'] as Timestamp;
    final DateTime dateTime = timestamp.toDate();
    final String formattedCreationDateTime =
        DateFormat('dd/MM/yy hh:mm a').format(dateTime);

    // Formatting the last edited date and time, if available
    final editedTimestamp = widget.diaryEntry['lastEdited'] as Timestamp?;
    final String formattedEditedDateTime = editedTimestamp != null
        ? DateFormat('dd/MM/yy hh:mm a').format(editedTimestamp.toDate())
        : 'N/A';

    bool isEdited = editedTimestamp != null &&
        !editedTimestamp.toDate().isAtSameMomentAs(dateTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diary Details'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEditSave,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Created: $formattedCreationDateTime',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (isEdited) ...[
              const SizedBox(height: 10),
              Text(
                'Edited: $formattedEditedDateTime',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
            const SizedBox(height: 10),
            const Text(
              'Diary:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: _isEditing
                    ? TextField(
                        controller: _noteController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(fontSize: 16),
                      )
                    : Text(
                        widget.diaryEntry['note'],
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
