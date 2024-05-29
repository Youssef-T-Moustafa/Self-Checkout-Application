import 'package:flutter/material.dart';
import 'package:map_project/models/productModel.dart';

class Cart extends ChangeNotifier {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
    notifyListeners(); // Notify listeners about the change
  }

  // Other cart-related methods...
}
