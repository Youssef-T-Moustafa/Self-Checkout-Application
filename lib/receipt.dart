import 'package:flutter/material.dart';
import 'package:map_project/models/cartModel.dart';

class ReceiptPage extends StatelessWidget {
  final Cart cart;

  ReceiptPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Receipt'),
      ),
      body: Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: cart.products.length,
            itemBuilder: (context, index) {
              var productEntry = cart.products.entries.elementAt(index);
              var product = productEntry.key;
              var quantity = productEntry.value;
              return ListTile(
                title: Text(product.name),
                subtitle: Text('Quantity: $quantity'),
                trailing:
                    Text('\$${(product.price * quantity).toStringAsFixed(2)}'),
              );
            },
          ),
          Text('Payment Confirmed',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
