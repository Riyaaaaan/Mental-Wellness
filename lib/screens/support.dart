import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key});

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
            leading: Icon(Icons.phone),
            title: Text('Emergency Contact'),
            subtitle: Text('Tap to call'),
            onTap: () {
              launchPhoneCall();
            },
          ),
          ListTile(
            leading: Icon(Icons.mail),
            title: Text('Contact Support'),
            subtitle: Text('Get in touch with our support team'),
            onTap: () {
              launchMailApp();
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: Text('FAQs'),
            onTap: () {
              sendSMS();
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
      query: 'subject=Support Request&body=Description of the issue',
    );

    var url = params.toString();
    if (await launchUrlString(url)) {
      await launchUrlString(url);
    } else {
      print('Could not launch $url');
    }
  }

  void launchPhoneCall() async {
    final phoneNumber = '+91 1800-599-0019';

    final Uri params = Uri(scheme: 'tel', path: phoneNumber);

    var url = params.toString();
    if (await launchUrlString(url)) {
      await launchUrlString(url);
    } else {
      print('Could not launch $url');
    }
  }

  void sendSMS() async {
    final phoneNumber = '112';
    final Uri params = Uri(scheme: 'sms', path: phoneNumber);

    var url = params.toString();
    if (await launchUrlString(url)) {
      await launchUrlString(url);
    } else {
      print('Could not send SMS to $phoneNumber');
    }
  }
}
