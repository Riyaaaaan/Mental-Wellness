import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MeditationsPage extends StatefulWidget {
  @override
  _MeditationsPageState createState() => _MeditationsPageState();
}

class _MeditationsPageState extends State<MeditationsPage> {
  late YoutubePlayerController _controller;
  final List<String> _videoIds = [
    'inpok4MKVLM', // Replace with your meditation video IDs
    '60Gnd8Wy0gE',
    'l_RteEP_pOI',
  ];

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: _videoIds.first, // Start with the first video in the list
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation Videos'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3, // Adjust flex to control the size of the video player
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player is ready.');
              },
            ),
          ),
          Expanded(
            flex: 2, // Adjust flex to control the size of the list
            child: ListView.builder(
              itemCount: _videoIds.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.play_circle_fill),
                    title: Text('Video ${index + 1}'),
                    onTap: () {
                      // Load and play the selected video
                      _controller.load(_videoIds[index]);
                      _controller.play();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
