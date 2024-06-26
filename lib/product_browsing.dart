import 'package:flutter/material.dart';
import 'package:map_project/models/productModel.dart';

class ProductBrowsingPage extends StatefulWidget {
  @override
  _ProductBrowsingPageState createState() => _ProductBrowsingPageState();
}

class _ProductBrowsingPageState extends State<ProductBrowsingPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Product> _products = [
    Product(
      name: 'Milk',
      description: 'Fresh cow milk',
      imageUrl: 'images/milk.jpg',
      category: 'Groceries',
      price: 10,
      discountedPrice: 8,
    ),
    Product(
      name: 'Bread',
      description: 'Whole grain bread',
      imageUrl: 'images/bread.jpg',
      category: 'Groceries',
      price: 5,
      discountedPrice: 4,
    ),
    Product(
      name: 'Eggs',
      description: 'Organic eggs',
      imageUrl: 'images/eggs.jpg',
      category: 'Groceries',
      price: 7,
      discountedPrice: 6,
    ),
    Product(
      name: 'Butter',
      description: 'Creamy butter',
      imageUrl: 'images/butter.jfif',
      category: 'Groceries',
      price: 8,
      discountedPrice: 7,
    ),
    Product(
      name: 'Cheese',
      description: 'Cheddar cheese',
      imageUrl: 'images/cheese.jpg',
      category: 'Groceries',
      price: 12,
      discountedPrice: 10,
    ),
    Product(
      name: 'Chicken',
      description: 'Fresh chicken',
      imageUrl: 'images/chicken.jpg',
      category: 'Meat',
      price: 15,
      discountedPrice: 12,
    ),
    Product(
      name: 'Fish',
      description: 'Fresh fish',
      imageUrl: 'images/fish.jpg',
      category: 'Meat',
      price: 20,
      discountedPrice: 18,
    ),
    Product(
      name: 'Apple',
      description: 'Red apples',
      imageUrl: 'images/apple.jfif',
      category: 'Fruits',
      price: 5,
      discountedPrice: 4,
    ),
    Product(
      name: 'Banana',
      description: 'Ripe bananas',
      imageUrl: 'images/banana.jpg',
      category: 'Fruits',
      price: 3,
      discountedPrice: 2,
    ),
    Product(
      name: 'Orange',
      description: 'Juicy oranges',
      imageUrl: 'images/orange.jpg',
      category: 'Fruits',
      price: 4,
      discountedPrice: 3,
    ),
  ];
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browse Products'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by product name',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                if (_searchQuery.isNotEmpty &&
                    !product.name.toLowerCase().contains(_searchQuery)) {
                  return Container(); // Skip this product if it doesn't match the search query
                }
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading:
                        Image.asset(product.imageUrl, width: 50, height: 50),
                    title: Text(product.name),
                    subtitle: Text(product.description),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
