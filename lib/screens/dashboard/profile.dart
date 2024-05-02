import 'package:flutter/material.dart';
import 'package:mental_wellness/screens/support.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_wellness/models/user.dart' as myUser;

import '../../provider/user_provider.dart';
import '../../utils/config.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      Config().init(context); // Initialize Config class here
      _initialized = true;
    }
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    myUser.User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: const Text('My Profile '),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                Card(
                  elevation: 5, // Add elevation here
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Config.widthSize! * 0.2),
                  ),
                  child: CircleAvatar(
                    radius: Config.widthSize! * 0.20,
                    backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3MQ1xQBc-cjR12FCSDQumeC798ZBc7F4vJhjcUqbkMga-jsOL8UB-_7Yzmf-1vPK8xc0&usqp=CAU",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Name :   ${user.name}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.person),
                ),
                ListTile(
                  title: Text(
                    'Username :   ${user.username}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.person),
                ),
                ListTile(
                  title: Text(
                    'Email : ${user.email}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.email),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    "Customer Support",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.headset_mic),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportPage()),
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.logout),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
