import 'package:flutter/material.dart';
import 'package:mental_wellness/firebase/auth_methods.dart';
import 'package:mental_wellness/models/user.dart' as myUser;

class UserProvider extends ChangeNotifier {
  myUser.User? _user; // Updated: Change the type to nullable User
  final AuthMethod _authMethod = AuthMethod();

  // Getter to access the user data
  myUser.User get user =>
      _user ??
      myUser.User(
        email: '',
        username: '',
        name: '', // Provide default values for name and userId
        userId: '',
      );

  // Method to refresh user data
  Future<void> refreshUser() async {
    myUser.User? user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
