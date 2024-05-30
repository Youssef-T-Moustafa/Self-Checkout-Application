import 'package:flutter/material.dart';

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

class Cart {
  List<CartItem> items;

  Cart({required this.items});

  double get totalPrice =>
      items.fold(0, (total, current) => total + current.totalPrice);
}

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
                onPressed: deliveryOption == ' Home Delivery'
                    ? null
                    : () {
                        setState(() {
                          deliveryOption = 'Home Delivery';
                        });
                      },
                child: Text(' Home Delivery'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled))
                        return Colors.grey;
                      return Colors.blue; // Use the component's default.
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
                      return Colors.blue; // Use the component's default.
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
                      return Colors.blue; // Use the component's default.
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
                      return Colors.blue; // Use the component's default.
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
                      return Colors.blue; // Use the component's default.
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
                : null,
            child: Text('Pay'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled))
                    return Colors.grey;
                  return Colors.green; // Use the component's default.
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
      cart: Cart(
        items: [
          CartItem(product: Product(name: 'Loai Juice', price: 10.0)),
          CartItem(product: Product(name: 'Siam Juice', price: 20.0)),
        ],
      ),
    ),
  ));
}
