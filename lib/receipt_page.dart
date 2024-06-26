import 'package:flutter/material.dart';
import 'package:map_project/models/cartModel.dart';
import 'package:map_project/homepage.dart';

class ReceiptPage extends StatelessWidget {
  final Cart cart;
  final String deliveryOption;
  final String paymentOption;

  ReceiptPage({
    required this.cart,
    required this.deliveryOption,
    required this.paymentOption,
  });

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
        title: Text('Receipt'),
        backgroundColor: Colors.orange,
        centerTitle: true,
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
                  ...cart.products.entries.map((entry) {
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
                    trailing: Text('\RM${cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Divider(),
                  SizedBox(height: 20.0),
                  Text('Delivery Option',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(deliveryOption),
                  ),
                  SizedBox(height: 20.0),
                  Text('Payment Option',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(paymentOption),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text('Back to Home',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
