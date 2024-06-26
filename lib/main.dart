import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_wellness/firebase_options.dart';
import 'package:mental_wellness/models/user.dart' as myUser;
import 'package:mental_wellness/provider/user_provider.dart';
import 'package:mental_wellness/screens/dashboard/dash_board.dart';
import 'package:mental_wellness/screens/login.dart';
import 'package:mental_wellness/screens/dashboard/notifications.dart';
import 'package:mental_wellness/screens/sign_up.dart';
import 'package:mental_wellness/screens/welcome_page.dart';
import 'package:mental_wellness/utils/local_noti.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotifications();
  await LocalNotificationService().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const WelcomePage(),
      routes: {
        '/notifications': (context) => NotificationPage(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            } else if (snapshot.hasData) {
              log('Successful');
              LocalNotificationService()
                  .showNotificationAndroid('Happify', 'Welcome to Happify');

              return const DashBoardPage();
            } else {
              log('Failed');

              return const AuthPage();
            }
          }),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogIn = true;
  @override
  Widget build(BuildContext context) =>
      isLogIn ? const LoginScreen() : const SignupPage();
}
