import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NatureSoundsPage extends StatefulWidget {
  @override
  _NatureSoundsPageState createState() => _NatureSoundsPageState();
}

class _NatureSoundsPageState extends State<NatureSoundsPage> {
  final List<Map<String, String>> _playlists = [
    {
      'id': '37i9dQZF1DX4PP3DA4J0N8',
      'title': 'Playlist 1',
      'url':
          'https://open.spotify.com/playlist/37i9dQZF1DX4PP3DA4J0N8?si=38bdf447bb674a4a',
    },
    {
      'id': '49LVboPXPu5glBOqzteVfI',
      'title': 'Playlist 2',
      'url':
          'https://open.spotify.com/album/49LVboPXPu5glBOqzteVfI?si=JVJYUqMiQc-uN1FfMBa55Q',
    },
    {
      'id': '3vpPY9mZEOe9z4th8RgzVd',
      'title': 'Playlist 3',
      'url':
          'https://open.spotify.com/album/3vpPY9mZEOe9z4th8RgzVd?si=O-PDrA9yTD-qKxexMQxvsQ',
    },
  ];

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $urlString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nature Sounds'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _playlists.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.play_circle_fill),
              title: Text(_playlists[index]['title']!),
              onTap: () {
                // Open the Spotify link
                _launchUrl(_playlists[index]['url']!);
              },
            ),
          );
        },
      ),
    );
  }
}
