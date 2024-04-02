import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mental_wellness/main.dart';

class FirebaseApi {
  //create instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notification
  Future<void> initNotifications() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();
    //fetch FCM token
    final fCMtoken = await _firebaseMessaging.getToken();

    //print token
    print('Token : $fCMtoken');
    //initialize further settings
    initPushNotifications();
  }

  //handle received messages
  void handleMessage(RemoteMessage? message) {
    //if message is null, do nothing
    if (message == null) return;
    //navigate to new page when message is received and user taps notifications
    navigatorKey.currentState?.pushNamed(
      '/notificationsScreen',
      arguments: message,
    );
  }

  //to initialize background settings
  Future<void> initPushNotifications() async {
    //handle notification if app terminated and opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    //attach event listener for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      // Handle the message here
      handleMessage(message);
    });
  }
}
