import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Add url_launcher package to your pubspec.yaml

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: Text('FAQs'),
            onTap: () {
              // Navigate to FAQs page or display FAQs dialog
            },
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Contact Support'),
            subtitle: Text('Get in touch with our support team'),
            onTap: () {
              // Launch mail app or navigate to contact form
              launchMailApp();
            },
          ),
          ListTile(
            leading: Icon(Icons.warning),
            title: Text('Emergency Contacts'),
            subtitle: Text('Immediate assistance'),
            onTap: () {
              // Display emergency contact numbers or navigate to a page with more details
              showEmergencyContacts(context);
            },
          ),
        ],
      ),
    );
  }

  void launchMailApp() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@example.com',
      query:
          'subject=Support Request&body=Description of the issue', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void showEmergencyContacts(BuildContext context) {
    // Implement your method to show emergency contacts
    // This could open a dialog or a new screen with the contact details
  }
}
