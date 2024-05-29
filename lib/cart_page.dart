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
              var productEntry = cart.products.entries.elementAt(index);
              var product = productEntry.key;
              var quantity = productEntry.value;
              return ListTile(
                leading: Image.network(product.imageUrl),
                title: Text(product.name),
                subtitle: Text(product.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        // Decrease quantity
                        cart.decreaseProductQuantity(product);
                      },
                    ),
                    Text('$quantity'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        // Increase quantity
                        cart.increaseProductQuantity(product);
                      },
                    ),
                    Text('\$${product.price.toStringAsFixed(2)}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
