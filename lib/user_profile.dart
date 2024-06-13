import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_project/homepage.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  void _saveChanges() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _firestore
          .doc('Swift/Users/AccountInfo/NfleBBxCOnaTOk4w3eyh')
          .update({
        'username': _usernameController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'phoneNumber': _phoneNumberController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future:
          _firestore.doc('Swift/Users/AccountInfo/NfleBBxCOnaTOk4w3eyh').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            _usernameController.text = data['username'];
            _firstNameController.text = data['firstName'];
            _lastNameController.text = data['lastName'];
            _emailController.text = data['email'];
            _phoneNumberController.text = data['phoneNumber'];
            return Scaffold(
              appBar: AppBar(
                title: Text('User Profile'),
                leading: BackButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => HomePage())));
                  },
                ),
                backgroundColor:
                    Colors.orange, // Set the AppBar color to orange
                centerTitle: true, // Center the title
                elevation: 10.0, // Add some shadow
              ),
              body: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('images/monkey.jpeg'),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildTextField('Username',
                        controller: _usernameController),
                    SizedBox(height: 16.0),
                    _buildTextField('First Name',
                        controller: _firstNameController),
                    SizedBox(height: 16.0),
                    _buildTextField('Last Name',
                        controller: _lastNameController),
                    SizedBox(height: 16.0),
                    _buildTextField('Email', controller: _emailController),
                    SizedBox(height: 16.0),
                    _buildTextField('Phone Number',
                        controller: _phoneNumberController),
                    SizedBox(height: 16.0),
                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width *
                          0.5, // Make the button less wide
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Give the button rounded corners
                          ),
                        ),
                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        onPressed: _saveChanges,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Text("Document does not exist");
          }
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildTextField(String title,
      {required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.white, // Change the fill color to white
            hintText: title,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ],
    );
  }
}
