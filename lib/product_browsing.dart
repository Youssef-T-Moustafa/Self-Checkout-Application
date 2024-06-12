import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final String imageUrl;
  final String category;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
  });
}

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
    ),
    Product(
      name: 'Bread',
      description: 'Whole grain bread',
      imageUrl: 'images/bread.jpg',
      category: 'Groceries',
    ),
    Product(
      name: 'Eggs',
      description: 'Organic eggs',
      imageUrl: 'images/eggs.jpg',
      category: 'Groceries',
    ),
    Product(
      name: 'Butter',
      description: 'Creamy butter',
      imageUrl: 'images/butter.jpg',
      category: 'Groceries',
    ),
    Product(
      name: 'Cheese',
      description: 'Cheddar cheese',
      imageUrl: 'images/cheese.jpg',
      category: 'Groceries',
    ),
    Product(
      name: 'Chicken',
      description: 'Fresh chicken',
      imageUrl: 'images/chicken.jpg',
      category: 'Meat',
    ),
    Product(
      name: 'Fish',
      description: 'Fresh fish',
      imageUrl: 'images/fish.jpg',
      category: 'Meat',
    ),
    Product(
      name: 'Apple',
      description: 'Red apples',
      imageUrl: 'images/apple.jpg',
      category: 'Fruits',
    ),
    Product(
      name: 'Banana',
      description: 'Ripe bananas',
      imageUrl: 'images/banana.jpg',
      category: 'Fruits',
    ),
    Product(
      name: 'Orange',
      description: 'Juicy oranges',
      imageUrl: 'images/orange.jpg',
      category: 'Fruits',
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
                labelText: 'Search by category',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchQuery = _searchController.text.toLowerCase();
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                if (_searchQuery.isNotEmpty &&
                    !product.category.toLowerCase().contains(_searchQuery)) {
                  return Container(); // Skip this product if it doesn't match the search query
                }
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: Image.asset(product.imageUrl, width: 50, height: 50),
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
