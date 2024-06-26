import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_project/cart_page.dart';
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
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
          },
        ),
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
                var items = List<Map<String, dynamic>>.from(data['items']);
                var orderItems = items.map((item) {
                  return ListTile(
                    title: Text(item['name'] ?? 'No Item'),
                    subtitle: Text('${item['quantity']} x \RM${item['price']}'),
                    trailing: Text('\RM${item['total']}'),
                  );
                }).toList();
                return ExpansionTile(
                  title: Text(
                      "Order placed on ${data['date'].toDate().toLocal()}"),
                  subtitle: Text("Total: \RM${data['total']}"),
                  children: [
                    ListTile(
                      title: Text("Delivery Address"),
                      subtitle: Text(data['address'] ?? 'No Address'),
                    ),
                    ListTile(
                      title: Text("Delivery Option"),
                      subtitle:
                          Text(data['deliveryOption'] ?? 'No Delivery Option'),
                    ),
                    ...orderItems,
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
