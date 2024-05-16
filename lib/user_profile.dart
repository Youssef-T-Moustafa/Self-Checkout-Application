import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      // Save changes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    'https://media.newyorker.com/photos/59095bb86552fa0be682d9d0/master/pass/Monkey-Selfie.jpg'),
              ),
            ),
            SizedBox(height: 16.0),
            _buildTextField('Username'),
            SizedBox(height: 16.0),
            _buildTextField('Name'),
            SizedBox(height: 16.0),
            _buildTextField('Email'),
            SizedBox(height: 16.0),
            _buildTextField('Phone Number'),
            SizedBox(height: 16.0),
            _buildTextField('Password', obscureText: true),
            SizedBox(height: 16.0),
            Text(
              'Date of Birth',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white, // Change the fill color to white
                hintText: 'Date of Birth',
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              },
            ),
            SizedBox(height: 16.0),
            Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width *
                  0.5, // Make the button less wide
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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
  }

  Widget _buildTextField(String title, {bool obscureText = false}) {
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
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.white, // Change the fill color to white
            hintText: title,
          ),
          obscureText: obscureText,
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
