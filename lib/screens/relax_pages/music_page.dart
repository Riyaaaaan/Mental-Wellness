import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final List<Map<String, String>> _spotifyLinks = [
    {
      "name": "Playlist 1",
      "url":
          "https://open.spotify.com/playlist/0eU3ubPAnqeSMi9K3YKVpC?si=s_7aYHZYQieBkMomVznKsQ",
    },
    {
      "name": "Playlist 2",
      "url":
          "https://open.spotify.com/album/4WJlT8rSyf9nf0YrdKriSO?si=ZjGpyaayS7eaQgDmy5KFSw",
    },
    {
      "name": "Playlist 3",
      "url":
          "https://open.spotify.com/episode/1qrRFZS0nRHx1WhbiiAJjN?si=WWLm7p2WThuxZt4BenNK0Q",
    },
    {
      "name": "Playlist 4",
      "url":
          "https://open.spotify.com/episode/65kSxIQ6377b87PJCOuFGl?si=w_2kwo-RTDys8lskrP5XMw",
    },
  ];

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      final bool launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        // If the specific app launch fails, try launching in a web browser
        await launchUrl(url, mode: LaunchMode.inAppWebView);
      }
    } else {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10, // Horizontal space between items
          mainAxisSpacing: 20, // Vertical space between items
          childAspectRatio: 1, // Aspect ratio of each item
        ),
        itemCount: _spotifyLinks.length,
        itemBuilder: (context, index) {
          var item = _spotifyLinks[index];
          return GestureDetector(
            onTap: () => _launchUrl(item['url']!),
            child: Card(
              elevation: 5,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item['name']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
