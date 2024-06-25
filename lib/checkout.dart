import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  double get totalPrice => product.price * quantity;
}

class Carts {
  List<CartItem> items;

  Carts({required this.items});

  double get totalPrice =>
      items.fold(0, (total, current) => total + current.totalPrice);
}

class CheckoutPage extends StatefulWidget {
  final Carts cart;

  CheckoutPage({required this.cart});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? deliveryOption;
  String? paymentOption;
  String address = 'Platinum Splendor, 54000 Kuala Lumpur';

  Future<void> sendReceiptEmail(String receiptDetails) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/send-receipt'), // Local server URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'receiptDetails': receiptDetails,
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

  void onPaymentSuccess() {
    String receiptDetails = widget.cart.items
            .map((item) =>
                '${item.quantity} x ${item.product.name} (\$${item.product.price})')
            .join(', ') +
        '. Total: \$${widget.cart.totalPrice}';

    sendReceiptEmail(receiptDetails);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Confirmed'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          ...widget.cart.items.map((item) {
            return ListTile(
              title: Text(item.product.name),
              subtitle: Text('${item.quantity} x \RM${item.product.price}'),
              trailing: Text('\RM${item.totalPrice}'),
            );
          }).toList(),
          SizedBox(height: 20.0),
          ListTile(
            title: Text('Total'),
            trailing: Text('\RM${widget.cart.totalPrice}'),
          ),
          SizedBox(height: 20.0),
          Text('Delivery Options', style: TextStyle(fontSize: 20.0)),
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
                child: Text('Home Delivery'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return Colors.blue;
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
                child: Text('Self Checkout'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return Colors.blue;
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          if (deliveryOption == 'Home Delivery') ...[
            ListTile(
              title: Text('Address'),
              subtitle: Text(address),
              trailing: TextButton(
                onPressed: () {
                  // Handle address editing here
                },
                child: Text('Edit Address'),
              ),
            ),
          ],
          SizedBox(height: 20.0),
          Text('Payment Options', style: TextStyle(fontSize: 20.0)),
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
                child: Text('FPX'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return Colors.blue;
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
                child: Text('Debit Card'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return Colors.blue;
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
                child: Text('Wallet'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return Colors.blue;
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: (deliveryOption != null && paymentOption != null)
                ? () {
                    onPaymentSuccess();
                  }
                : null,
            child: Text('Pay'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled))
                    return Colors.grey;
                  return Colors.green;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckoutPage(
      cart: Carts(
        items: [
          CartItem(product: Product(name: 'Hamido-Goreng-Kunyit', price: 6.7)),
        ],
      ),
    ),
  ));
}
