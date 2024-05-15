import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_project/log_in.dart';
import 'package:map_project/services/toast.dart';
import 'package:map_project/barcode_scanner.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                showToast(message: 'Sign Out Successfully');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Sign Out'),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                showToast(message: 'Sign Out Successfully');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BarcodeScanner()));
              },
              child: const Text('Scanner'),
            ),
          ),
        ],
      ),
    );
  }
}
