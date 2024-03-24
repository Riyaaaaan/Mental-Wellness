import 'package:flutter/material.dart';
import '../screens/relax_pages/books_page.dart';
import '../screens/relax_pages/meditation_page.dart';
import '../screens/relax_pages/music_page.dart';
import '../screens/relax_pages/nature_sounds_page.dart';
import '../screens/relax_pages/podcast_page.dart';
import '../screens/relax_pages/yoga_page.dart';

class RelaxPage extends StatelessWidget {
  const RelaxPage({Key? key}) : super(key: key);

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
        title: const Text('Relaxation'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildItem(context, 'Books', const BooksPage()),
          _buildItem(context, 'Music', const MusicPage()),
          _buildItem(context, 'Meditations', MeditationsPage()),
          _buildItem(context, 'Podcasts', const PodcastPage()),
          _buildItem(context, 'Yoga', const YogaPage()),
          _buildItem(context, 'Nature Sounds', NatureSoundsPage()),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
