import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_project/cart_page.dart';
import 'package:map_project/log_in.dart';
import 'package:map_project/services/toast.dart';
import 'package:map_project/barcode_scanner.dart';
import 'package:map_project/order_page.dart';
import 'package:map_project/user_profile.dart';
import 'package:map_project/models/productModel.dart';
import 'package:map_project/product_browsing.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Product> _products = [
    Product(
      name: 'Milk',
      description: 'Fresh cow milk',
      imageUrl: 'images/milk.jpg',
      category: 'Groceries',
      price: 2.0,
      discountedPrice: 1.5,
    ),
    Product(
      name: 'Bread',
      description: 'Whole grain bread',
      imageUrl: 'images/bread.jpg',
      category: 'Groceries',
      price: 1.5,
      discountedPrice: 1.0,
    ),
    Product(
      name: 'Eggs',
      description: 'Organic eggs',
      imageUrl: 'images/eggs.jpg',
      category: 'Groceries',
      price: 3.0,
      discountedPrice: 2.5,
    ),
    Product(
      name: 'Butter',
      description: 'Creamy butter',
      imageUrl: 'images/butter.jfif',
      category: 'Groceries',
      price: 2.5,
      discountedPrice: 2.0,
    ),
    Product(
      name: 'Cheese',
      description: 'Cheddar cheese',
      imageUrl: 'images/cheese.jpg',
      category: 'Groceries',
      price: 4.0,
      discountedPrice: 3.5,
    ),
    Product(
      name: 'Chicken',
      description: 'Fresh chicken',
      imageUrl: 'images/chicken.jpg',
      category: 'Meat',
      price: 6.0,
      discountedPrice: 5.0,
    ),
    Product(
      name: 'Fish',
      description: 'Fresh fish',
      imageUrl: 'images/fish.jpg',
      category: 'Meat',
      price: 5.0,
      discountedPrice: 4.0,
    ),
    Product(
      name: 'Apple',
      description: 'Red apples',
      imageUrl: 'images/apple.jfif',
      category: 'Fruits',
      price: 2.0,
      discountedPrice: 1.5,
    ),
    Product(
      name: 'Banana',
      description: 'Ripe bananas',
      imageUrl: 'images/banana.jpg',
      category: 'Fruits',
      price: 1.8,
      discountedPrice: 1.2,
    ),
    Product(
      name: 'Orange',
      description: 'Juicy oranges',
      imageUrl: 'images/orange.jpg',
      category: 'Fruits',
      price: 2.5,
      discountedPrice: 2.0,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Home
        break;
      case 1:
        // Notifications
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BarcodeScanner()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfile()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.sick_outlined),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => OrderPage()));
          },
        ),
        title: Text(
          'Home Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        elevation: 10.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductBrowsingPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Discounted Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              product.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '\$${product.discountedPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
