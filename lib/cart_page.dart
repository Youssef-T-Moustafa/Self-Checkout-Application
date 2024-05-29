import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:map_project/models/cartModel.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(cart.products[index].imageUrl),
                title: Text(cart.products[index].name),
                subtitle: Text(cart.products[index].description),
                trailing:
                    Text('\$${cart.products[index].price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}
