import 'package:flutter/material.dart';
import 'package:map_project/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_project/homepage.dart';
import 'package:map_project/sign_up.dart';
import 'package:map_project/services/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'email',
              ),
              controller: _emailController,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signIn,
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text('Login'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      isLoading = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    setState(() {
      isLoading = false;
    });

    if (user != null) {
      showToast(message: "Login successful");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      print("success");
    } else {
      showToast(message: "Login failed");
      print("error");
    }
  }
}
