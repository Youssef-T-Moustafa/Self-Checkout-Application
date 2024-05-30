import 'package:flutter/material.dart';
import 'checkout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Cart cart = Cart(
    items: [
      CartItem(product: Product(name: 'Loai Juice', price: 10.0), quantity: 2),
      CartItem(product: Product(name: 'Siam Juice', price: 20.0), quantity: 1),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckoutPage(cart: cart)),
            );
          },
          child: Text('Go to Checkout'),
        ),
      ),
    );
  }
}
