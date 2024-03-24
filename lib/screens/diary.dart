import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../firestore_methods.dart';
import 'diary_details.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final TextEditingController _diaryController = TextEditingController();
  late List<Map<String, dynamic>> _diaryEntries; // List to store diary entries

  @override
  void initState() {
    super.initState();
    _diaryEntries = <Map<String, dynamic>>[]; // Initialize diary entries list
    _fetchDiaryEntries(); // Fetch diary entries from Firestore
  }

  @override
  void dispose() {
    _diaryController.dispose(); // Dispose of controller to avoid memory leaks
    super.dispose();
  }

  Future<void> _addDiaryEntry() async {
    //Hide the keyboard
    FocusScope.of(context).unfocus();
    try {
      await FirestoreMethods.addDiaryEntry(_diaryController.text);
      _diaryController.clear();
      await _fetchDiaryEntries(); // Refresh the diary entries
    } catch (e) {
      // Handle the error, e.g., showing an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _fetchDiaryEntries() async {
    final entries = await FirestoreMethods.fetchDiaryEntries();
    setState(() {
      _diaryEntries = entries;
    });
  }

  Future<void> _deleteDiaryEntry(BuildContext context, String docId) async {
    // Show dialog to confirm deletion
    final bool confirmDelete = await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Confirm'),
            content:
                const Text('Are you sure you want to delete this diary entry?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false; // Handling null (if dialog is dismissed)

    if (confirmDelete) {
      try {
        await FirestoreMethods.deleteDiaryEntry(docId);
        await _fetchDiaryEntries(); // Refresh the entries after deletion
      } catch (e) {
        // Handle the error, e.g., showing an error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(e.toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double halfScreenHeight = screenHeight / 2;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: const Text('My Diary'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newDiaryEntryCard(halfScreenHeight),
            const SizedBox(height: 10),
            diaryEntriesCard(halfScreenHeight),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Card newDiaryEntryCard(double height) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: SizedBox(
        height: height - 30,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'New Entry',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TextField(
                  controller: _diaryController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _addDiaryEntry,
                child: const Text('Save Entry'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Card diaryEntriesCard(double height) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: SizedBox(
        height: height - 20,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: _diaryEntries.isEmpty
              ? const Center(child: Text('No diary entries available.'))
              : ListView.builder(
                  itemCount: _diaryEntries.length,
                  itemBuilder: (context, index) {
                    final diaryEntry = _diaryEntries[index];
                    return Column(
                      children: [
                        ListTile(
                          title: InkWell(
                            onTap: () async {
                              // Assuming DiaryDetails is a detailed view for each diary entry
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DiaryEntryDetails(diaryEntry: diaryEntry),
                                ),
                              );
                              _fetchDiaryEntries(); // Refresh after navigating back
                            },
                            child: Text(
                              diaryEntry['note'].split(
                                  '\n')[0], // Show the first line as the title
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const VerticalDivider(
                                width: 20,
                                thickness: 2,
                                indent: 10,
                                endIndent: 10,
                                color: Colors.grey,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteDiaryEntry(
                                    context, diaryEntry['id']),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
