import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_wellness/models/user.dart' as myUser;
import 'package:mental_wellness/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../components/appoint_card.dart';
import '../components/doctor_card.dart';
import '../utils/config.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final myUser.User user = userProvider.user;
    Config().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Config.widthSize! * 0.05,
          vertical: Config.heightSize! * 0.05,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${user.username}",
                      style: TextStyle(
                        fontSize: Config.widthSize! * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: Config.widthSize! * 0.2,
                      child: CircleAvatar(
                        radius: Config.widthSize! * 0.1,
                        backgroundImage: NetworkImage(
                          "${"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3MQ1xQBc-cjR12FCSDQumeC798ZBc7F4vJhjcUqbkMga-jsOL8UB-_7Yzmf-1vPK8xc0&usqp=CAU"}",
                        ),
                      ),
                    ),
                    Config.spaceMedium,
                  ],
                ),
                Config.spaceSmall,
                Text(
                  "Appointment Today",
                  style: TextStyle(
                    fontSize: Config.widthSize! * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                AppointCard(),
                Config.spaceSmall,
                Text(
                  "Top Doctors",
                  style: TextStyle(
                    fontSize: Config.widthSize! * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                Column(
                  children: List.generate(
                    5,
                    (index) => const DoctorCard(
                      route: 'doc_details',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
