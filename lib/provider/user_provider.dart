import 'package:flutter/material.dart';
import 'package:mental_wellness/models/user_model.dart';

class UserProvider with ChangeNotifier {
  User _user = User(
    imageUrl: 'https://via.placeholder.com/150',
    username: 'JohnDoe',
    mobileNumber: '+123456789',
    email: 'johndoe@example.com',
  );

  User get user => _user;

  void updateUser(String username, String mobileNumber, String email) {
    _user.username = username;
    _user.mobileNumber = mobileNumber;
    _user.email = email;
    notifyListeners();
  }
}
