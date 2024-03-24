import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final List<Map<String, String>> _books = [
    {
      'title': 'Sustainable Development Goals',
      'url':
          'https://www.junkybooks.com/book/reader.php?book=thebooks/65ab1c7c15562-alleem-sustainable-development-goals.pdf',
    },
    {
      'title': 'Loving What Is',
      'url':
          'https://www.junkybooks.com/book/reader.php?book=thebooks/64e295ab7e5a2-loving-what-is.pdf',
    },
    {
      'title': 'Start Where You Are',
      'url':
          'https://www.junkybooks.com/book/reader.php?book=thebooks/64e23253c0961-start-where-you-are.pdf',
    },
    {
      'title': '13 Things Mentally Strong People Don\'t Do',
      'url':
          'https://www.junkybooks.com/book/reader.php?book=thebooks/64b13e73c738c-13-things-mentally-strong-people-don-t-do.pdf',
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
    // Calculate the aspect ratio based on screen size
    // This is a simple heuristic. You might need to adjust it based on your needs or use MediaQuery for more complex calculations
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    var aspectRatio = (width / 2) /
        (height /
            4); // Assuming 2 columns and wanting 4 rows to fill the screen

    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 4.0, // Space between columns
          mainAxisSpacing: 8.0, // Space between rows
          childAspectRatio: aspectRatio, // Adjust based on screen size
        ),
        itemCount: _books.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _launchUrl(_books[index]['url']!),
            child: Card(
              color: Colors.blue, // Set the color of the Card
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.book,
                    size: 50,
                    color: Colors.white,
                  ), // Adjust icon color for better contrast
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _books[index]['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ), // Adjust text style as needed for better contrast
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
