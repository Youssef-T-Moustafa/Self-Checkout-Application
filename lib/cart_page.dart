import 'package:flutter/material.dart';
import 'package:map_project/checkout.dart';
import 'package:map_project/homepage.dart';
import 'package:provider/provider.dart';
import 'package:map_project/models/cartModel.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: ((context) => HomePage())));
          },
        ),
        backgroundColor: Colors.orange, // Set the AppBar color to orange
        centerTitle: true, // Center the title
        elevation: 10.0, // Add some shadow
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.products.length,
                  itemBuilder: (context, index) {
                    var productEntry = cart.products.entries.elementAt(index);
                    var product = productEntry.key;
                    var quantity = productEntry.value;
                    return ListTile(
                      leading: _buildProductImage(product.imageUrl),
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
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Checkout',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage(cart: cart)));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange // Text color
                      ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    if (Uri.tryParse(imageUrl)?.isAbsolute == true) {
      return Image.network(imageUrl, fit: BoxFit.cover);
    } else {
      return Image.asset(imageUrl, fit: BoxFit.cover);
    }
  }
}
