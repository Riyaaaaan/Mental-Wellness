import 'package:flutter/material.dart';

class YogaPage extends StatelessWidget {
  const YogaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga'),
      ),
      body: const Center(
        child: Text('Yoga Page'),
      ),
    );
  }
}
