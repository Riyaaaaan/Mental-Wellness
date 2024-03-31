import 'package:flutter/material.dart';
import 'package:mental_wellness/screens/success_booked.dart';

import '../utils/config.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

enum FilterStatus { upcoming, complete, cancel }

class _AppointmentPageState extends State<AppointmentPage> {
  FilterStatus status = FilterStatus.upcoming;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedule = [
    {
      'doctor_name': 'John Wick',
      'doctor_profile': 'assets/Rectangle 5201.png',
      'category': 'Psychologist',
      'status': FilterStatus.upcoming,
    },
    {
      'doctor_name': 'John Wick',
      'doctor_profile': 'assets/Rectangle 5201 (1).png',
      'category': 'Psychologist',
      'status': FilterStatus.complete,
    },
    {
      'doctor_name': 'John Wick',
      'doctor_profile': 'assets/Rectangle 5201.png',
      'category': 'Psychologist',
      'status': FilterStatus.complete,
    },
    {
      'doctor_name': 'John Wick',
      'doctor_profile': 'assets/Rectangle 5201 (1).png',
      'category': 'Psychologist',
      'status': FilterStatus.cancel,
    }
  ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> filterSchedule = schedule.where((var _schedule) {
      return _schedule['status'] == status;
    }).toList();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            const Text(
              "Appointment Schedule",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Config.spaceSmall,
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (FilterStatus filterStatus in FilterStatus.values)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (filterStatus == FilterStatus.upcoming) {
                                  status = FilterStatus.upcoming;
                                  _alignment = Alignment.centerLeft;
                                } else if (filterStatus ==
                                    FilterStatus.complete) {
                                  status = FilterStatus.complete;
                                  _alignment = Alignment.center;
                                } else if (filterStatus ==
                                    FilterStatus.cancel) {
                                  status = FilterStatus.cancel;
                                  _alignment = Alignment.centerRight;
                                }
                              });
                            },
                            child: Center(
                              child:
                                  Text(filterStatus.toString().split('.').last),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                AnimatedAlign(
                  alignment: _alignment,
                  duration: const Duration(
                      milliseconds: 200), // Changed to milliseconds
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Config.primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        status.toString().split('.').last,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Config.spaceSmall,
            Expanded(
              child: ListView.builder(
                itemCount: filterSchedule.length,
                itemBuilder: (context, index) {
                  var _schedule = filterSchedule[index];
                  bool isLastElement =
                      index == filterSchedule.length - 1; // Corrected condition
                  return Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    margin: !isLastElement
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(_schedule['doctor_profile']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['doctor_name'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _schedule['category'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const ScheduleCard(),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const AppointmentBooked();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Config.primaryColor),
                                ),
                              )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Config.primaryColor),
                                onPressed: () {},
                                child: const Text(
                                  'Reschedule',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.calendar_today,
            color: Config.primaryColor,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Monday, 11/28/2022",
            style: TextStyle(color: Config.primaryColor),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Config.primaryColor,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            "2:00 PM",
            style: TextStyle(color: Config.primaryColor),
          ))
        ],
      ),
    );
  }
}
