import 'package:flutter/material.dart';
import 'package:map_project/cart_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_project/barcode_scanner.dart';
import 'package:map_project/homepage.dart';
import 'package:map_project/user_profile.dart';

Future<List<DocumentSnapshot>> fetchData() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Swift')
      .doc("History")
      .collection("Orders")
      .get();
  return querySnapshot.docs;
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.orange[50], // Set the background color to light orange
      appBar: AppBar(
        title: Text(
          'Order History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange, // Set the AppBar color to orange
        centerTitle: true, // Center the title
        elevation: 10.0, // Add some shadow
      ),

      body: FutureBuilder<List<DocumentSnapshot>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          } else {
            return ListView(
              children: snapshot.data!.map((document) {
                var data = document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['Item'] ?? 'No Item'),
                  subtitle: Text("Bought on: ${data['Date'] ?? 'No data'}"),
                  trailing: Text("\$ ${data['Price'] ?? 'No Item'}",
                    style: TextStyle(fontSize: 18), // Set the font size to 18
                  ),
                  isThreeLine: true,
                );
              }).toList(),
            );
          }
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey, // Set the color of the selected item
        unselectedItemColor:
            Colors.black, // Set the color of the unselected items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage()));
              break;
            case 1:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomePage()));
              break;
            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BarcodeScanner()));
              break;
            case 3:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CartPage()));
              break;
            case 4:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
              break;
          }

        },
      ),
    );
  }
}
