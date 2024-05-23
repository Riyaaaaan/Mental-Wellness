import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_wellness/screens/dashboard/dash_board.dart';

class CompletedPage extends StatefulWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  State<CompletedPage> createState() => _LottieAnimeState();
}

class _LottieAnimeState extends State<CompletedPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.stop();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.network(
              'https://lottie.host/0844b20e-bb5d-4b1f-b78a-bda4d05337d6/CCfB1wIa5U.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Completed !',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          OutlinedButton(
            child: Text(
              'Continue',
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DashBoardPage();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
