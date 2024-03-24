import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String username; // Updated: Removed 'final' keyword
  String name;
  final String userId;

  User({
    required this.email,
    required this.username,
    required this.name,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
      };

  static User? fromSnap(DocumentSnapshot? snap) {
    if (snap == null || !snap.exists) {
      return null;
    }

    var snapshot = snap.data() as Map<String, dynamic>?;

    if (snapshot == null) {
      return null; // Return null or handle the absence of data according to your logic
    }

    return User(
      username: snapshot['username'],
      email: snapshot['email'],
      name: snapshot['name'],
      userId: snapshot['userId'],
    );
  }
}
