import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:map_project/models/productModel.dart';
import 'package:map_project/models/cartModel.dart';
import 'package:map_project/order_page.dart';
import 'package:map_project/receipt_page.dart'; // Ensure this import is correct

class CheckoutPage extends StatefulWidget {
  final Cart cart;

  CheckoutPage({required this.cart});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? deliveryOption;
  String? paymentOption;
  String address = 'Platinum Splendor, 54000 Kuala Lumpur';
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressController.text = address;
  }

  Future<void> sendReceiptEmail(String receiptDetails, String email) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/send-receipt'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'receiptDetails': receiptDetails,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        print('Email sent successfully');
      } else {
        print('Failed to send email: ${response.body}');
      }
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  Future<void> saveOrderToFirestore() async {
    CollectionReference orders = FirebaseFirestore.instance
        .collection('Swift')
        .doc("History")
        .collection("Orders");

    List<Map<String, dynamic>> orderItems =
        widget.cart.products.entries.map((entry) {
      return {
        'name': entry.key.name,
        'quantity': entry.value,
        'price': entry.key.price,
        'total': entry.value * entry.key.price,
      };
    }).toList();

    await orders.add({
      'items': orderItems,
      'total': widget.cart.totalPrice,
      'address': address,
      'deliveryOption': deliveryOption,
      'paymentOption': paymentOption,
      'date': Timestamp.now(),
    });
  }

  void onPaymentSuccess() async {
    String receiptDetails = widget.cart.products.entries
            .map((entry) =>
                '${entry.value} x ${entry.key.name} (\RM${entry.key.price.toStringAsFixed(2)})')
            .join(', ') +
        '. Total: \RM${widget.cart.totalPrice.toStringAsFixed(2)}';

    String email =
        "engineerloai108@gmail.com"; // Replace with the actual recipient email

    await sendReceiptEmail(receiptDetails, email);
    await saveOrderToFirestore();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPage(
          cart: widget.cart,
          deliveryOption: deliveryOption!,
          paymentOption: paymentOption!,
        ),
      ),
    );
  }

  void showEditAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Address'),
          content: TextField(
            controller: addressController,
            decoration: InputDecoration(
              hintText: 'Enter new address',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  address = addressController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductImage(String imageUrl) {
    if (Uri.tryParse(imageUrl)?.isAbsolute == true) {
      return Image.network(imageUrl, fit: BoxFit.cover, width: 50, height: 50);
    } else {
      return Image.asset(imageUrl, fit: BoxFit.cover, width: 50, height: 50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        backgroundColor: Colors.orange, // Set the AppBar color to orange
        centerTitle: true, // Center the title
        elevation: 10.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ...widget.cart.products.entries.map((entry) {
                    return ListTile(
                      leading: _buildProductImage(entry.key.imageUrl),
                      title: Text(entry.key.name),
                      subtitle: Text(
                          '${entry.value} x \RM${entry.key.price.toStringAsFixed(2)}'),
                      trailing: Text(
                          '\RM${(entry.value * entry.key.price).toStringAsFixed(2)}'),
                    );
                  }).toList(),
                  SizedBox(height: 20.0),
                  Divider(),
                  ListTile(
                    title: Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text(
                        '\RM${widget.cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Divider(),
                  SizedBox(height: 20.0),
                  Text('Delivery Options',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: deliveryOption == 'Home Delivery'
                            ? null
                            : () {
                                setState(() {
                                  deliveryOption = 'Home Delivery';
                                });
                              },
                        child: Text('Home Delivery',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled))
                                return Colors.green;
                              return Colors.orange;
                            },
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: deliveryOption == 'Self Checkout'
                            ? null
                            : () {
                                setState(() {
                                  deliveryOption = 'Self Checkout';
                                });
                              },
                        child: Text('Self Checkout',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled))
                                return Colors.green;
                              return Colors.orange;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (deliveryOption == 'Home Delivery') ...[
                    SizedBox(height: 20.0),
                    ListTile(
                      title: Text('Address'),
                      subtitle: Text(address),
                      trailing: TextButton(
                        onPressed: () {
                          showEditAddressDialog();
                        },
                        child: Text('Edit Address'),
                      ),
                    ),
                  ],
                  SizedBox(height: 20.0),
                  Text('Payment Options',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: paymentOption == 'FPX'
                            ? null
                            : () {
                                setState(() {
                                  paymentOption = 'FPX';
                                });
                              },
                        child:
                            Text('FPX', style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled))
                                return Colors.green;
                              return Colors.orange;
                            },
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: paymentOption == 'Debit Card'
                            ? null
                            : () {
                                setState(() {
                                  paymentOption = 'Debit Card';
                                });
                              },
                        child: Text('Debit Card',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled))
                                return Colors.green;
                              return Colors.orange;
                            },
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: paymentOption == 'Wallet'
                            ? null
                            : () {
                                setState(() {
                                  paymentOption = 'Wallet';
                                });
                              },
                        child: Text('Wallet',
                            style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled))
                                return Colors.green;
                              return Colors.orange;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: (deliveryOption != null && paymentOption != null)
                    ? () {
                        onPaymentSuccess();
                      }
                    : null,
                child: Text('Pay',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return Colors.orange;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
