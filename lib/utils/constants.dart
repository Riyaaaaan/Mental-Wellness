import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mental_wellness/reminder/reminder_page_one.dart';
import 'package:mental_wellness/screens/dashboard/booking_page.dart';
import 'package:mental_wellness/screens/dashboard/chat.dart';
import 'package:mental_wellness/screens/dashboard/dash_board.dart';
import 'package:mental_wellness/screens/dashboard/home_page.dart';
import 'package:mental_wellness/screens/dashboard/profile.dart';

const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);

const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);

List<Map<String, dynamic>> docList = [
  {
    "image": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
    ),
    "name": "Dr.Marc Saunders",
    "position": "Psychologist",
    "hospital": "Sunrise Hospital",
  },
  {
    "image": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
    ),
    "name": "Dr.Samanta Lane",
    "position": "Psychologist",
    "hospital": "Sunrise Hospital"
  },
  {
    "image": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
    ),
    "name": "Dr.Sadie Gilbert",
    "position": "Therapist",
    "hospital": "Lissie Hospital",
  },
  {
    "image": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
    ),
    "name": "Dr.Olga Dennis",
    "position": "Psychiatrist",
    "hospital": "Sunrise Hospital"
  },
  {
    "image": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
    ),
    "name": "Dr.Laura Daniels",
    "position": "Counsellor",
    "hospital": "Lissie Hospital"
  },
  {
    "image": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
    ),
    "name": "Dr.Russell Christensen",
    "position": "Psychologist",
    "hospital": "Amrita Hospital"
  },
  {
    "image": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
    ),
    "name": "Dr.Maria Davidson",
    "position": "Psychologist",
    "hospital": "Medical Trust"
  },
  {
    "image": Image.network(
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5IPj8bOq0BhZcQaOzwLEuiyiW0FiMSKDl7eUOS8tj4nhuAjujoO7mIoxdlw&s",
    ),
    "name": "Dr.Katherine Warner",
    "position": "Psychologist",
    "hospital": "Amrita Hospital"
  },
];
List<Map<String, dynamic>> docLists = [
  {
    "image": Image.asset("assets/Rectangle 5201 (1).png"),
    "name": "Dr.Joe Parks",
    "position": "Psychologist",
    "hospital": "Aster Medicity"
  },
  {
    "image": Image.asset("assets/Rectangle 5201.png"),
    "name": "Dr.Charlotte Stephens",
    "position": "Psychologist",
    "hospital": "Laskshmi Hospital"
  },
];

const screens = [
  DashBoardPage(),
  HomePage(),
  BookingPage(),
  ChatScreen(),
  Reminder(),
  // ProfilePage(),
];
