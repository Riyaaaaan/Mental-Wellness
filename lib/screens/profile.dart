import 'package:flutter/material.dart';
import 'package:mental_wellness/screens/support.dart';
import '../models/user_model.dart' as myUser;
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  myUser.User user = myUser.User(
    imageUrl: 'https://via.placeholder.com/150',
    username: 'JohnDoe',
    mobileNumber: '+123456789',
    email: 'johndoe@example.com',
  );

  bool isEditing = false;

  late TextEditingController _usernameController;
  late TextEditingController _mobileNumberController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: user.username);
    _mobileNumberController = TextEditingController(text: user.mobileNumber);
    _emailController = TextEditingController(text: user.email);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Profile Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                // Save the changes
                setState(() {
                  user.username = _usernameController.text;
                  user.mobileNumber = _mobileNumberController.text;
                  user.email = _emailController.text;
                  isEditing = false;
                });
              } else {
                // Enable editing
                setState(() {
                  isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
                const SizedBox(height: 20),
                isEditing
                    ? _editableField("Username", _usernameController)
                    : _nonEditableField(
                        "Username", user.username, Icons.person),
                isEditing
                    ? _editableField("Mobile Number", _mobileNumberController)
                    : _nonEditableField(
                        "Mobile Number", user.mobileNumber, Icons.phone),
                isEditing
                    ? _editableField("Email", _emailController)
                    : _nonEditableField("Email", user.email, Icons.email),
                _customerSupportSection(),
                _signOutSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nonEditableField(String label, String value, IconData icon) {
    return ListTile(
      title: Text(value),
      leading: Icon(icon),
    );
  }

  Widget _editableField(String label, TextEditingController controller) {
    return ListTile(
      title: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  Widget _customerSupportSection() {
    return ListTile(
      title: const Text(
        "Customer Support",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: const Icon(Icons.headset_mic),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SupportPage()),
        );
      },
      enabled:
          !isEditing, // Disables the customer support tile during editing mode
    );
  }

  Widget _signOutSection() {
    return ListTile(
      title: const Text(
        "Sign Out",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      leading: const Icon(Icons.logout),
      onTap: () async {
        FirebaseAuth.instance.signOut();
        await Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      },
      enabled: !isEditing, // Disables the sign out tile during editing mode
    );
  }
}
