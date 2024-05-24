import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_wellness/screens/dashboard/appointment.dart';
import 'package:mental_wellness/screens/dashboard/dash_board.dart';

import '../components/button.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AppointmentPage(),
      )),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Lottie.asset(
                  "assets/134734-waves.json",
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  "Successfully Booked",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Button(
                  width: double.infinity,
                  title: "Back to home",
                  onPress: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return DashBoardPage();
                    },
                  )),
                  disble: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
