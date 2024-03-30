import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_wellness/models/user.dart' as myUser;
import 'package:mental_wellness/reminder/reminder_page_one.dart';
import 'package:mental_wellness/screens/booking_page.dart';
import 'package:mental_wellness/screens/chat.dart';
import 'package:mental_wellness/screens/diary.dart';
import 'package:mental_wellness/screens/home_page.dart';
import 'package:mental_wellness/screens/mood_page.dart';
import 'package:mental_wellness/screens/notifications.dart';
import 'package:mental_wellness/screens/phsycologist_list.dart';
import 'package:mental_wellness/screens/profile.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import '../reminder/relux.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  List<Map<String, dynamic>> docList = [
    {
      "image": Image.asset("assets/Rectangle 5201 (1).png"),
      "name": "Dr.Samanta Lane",
      "position": "Psychologist",
      "hospital": "Square"
    },
    {
      "image": Image.asset("assets/Rectangle 5201.png"),
      "name": "Dr.Deven Lane",
      "position": "Psychologist",
      "hospital": "Square"
    },
  ];
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final myUser.User user = userProvider.user;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xffFAFCFE),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: Image.asset("assets/home.png"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BookingPage(),
                  ),
                );
              },
              child: Image.asset("assets/book.png"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                );
              },
              child: Image.asset(
                height: 30,
                'assets/mic.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Reminder(),
                  ),
                );
              },
              child: Image.asset("assets/notification.png"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: Image.asset("assets/user.png"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hey ${user.username}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications_active),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "We are here to help you",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  //* ROW
                  child: featureSection(screenHeight, context),
                ),
                SizedBox(height: screenHeight * 0.02),
                //* BANNER
                bannerSection(screenHeight),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Psychologist",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.07,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PsycologistList(),
                          ),
                        );
                      },
                      child: const Text(
                        "See all",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                doctorListSection(screenHeight, screenWidth)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row featureSection(double screenHeight, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              height: screenHeight * 0.1,
              width: screenHeight * 0.1,
              decoration: BoxDecoration(
                color: const Color(0xffFFD4E5),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 0.02),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const PsycologistList();
                      },
                    ),
                  );
                },
                child: Image.asset(
                  "assets/doctor 1.png",
                ),
              ),
            ),
            const Text("Psychologist")
          ],
        ),
        SizedBox(width: screenHeight * 0.02), // Adjust the width here
        Column(
          children: [
            Container(
              height: screenHeight * 0.1,
              width: screenHeight * 0.1,
              decoration: BoxDecoration(
                color: const Color(0xffCEFFEB),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 0.02),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const MoodTrackerPage();
                      },
                    ),
                  );
                },
                child: Image.asset(
                  "assets/statistics 1.png",
                ),
              ),
            ),
            const Text("Mood Track")
          ],
        ),
        SizedBox(width: screenHeight * 0.02), // Adjust the width here
        Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RelaxPage(),
                  ),
                );
              },
              child: Container(
                height: screenHeight * 0.1,
                width: screenHeight * 0.1,
                decoration: BoxDecoration(
                  color: const Color(0xffCEFFEB),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenHeight * 0.02),
                  ),
                ),
                child: Image.asset(
                  "assets/meditation (1) 1.png",
                ),
              ),
            ),
            const Text("Relaxation")
          ],
        ),
        SizedBox(width: screenHeight * 0.02), // Adjust the width here
        Column(
          children: [
            Container(
              height: screenHeight * 0.1,
              width: screenHeight * 0.1,
              decoration: BoxDecoration(
                color: const Color(0xffFFDFC0),
                borderRadius: BorderRadius.all(
                  Radius.circular(screenHeight * 0.02),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiaryPage(),
                    ),
                  );
                },
                child: Image.asset(
                  "assets/diary.png",
                ),
              ),
            ),
            const Text("Diary")
          ],
        ),
        SizedBox(width: screenHeight * 0.02),
      ],
    );
  }

  SizedBox bannerSection(double screenHeight) {
    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.2,
      child: Image.asset(
        "assets/Group 1000007408.png",
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }

  SizedBox doctorListSection(double screenHeight, double screenWidth) {
    return SizedBox(
        height: screenHeight * 0.4,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: List<Widget>.generate(docList.length, (index) {
            return Card(
              margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01,
                  horizontal: screenHeight * 0.01),
              child: Row(
                children: [
                  docList[index]['image'],
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        docList[index]['name'],
                        style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(docList[index]['position']),
                      Text(
                        docList[index]['hospital'],
                        style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            fontWeight: FontWeight.w300,
                            color: Colors.blue),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        ));
  }
}
