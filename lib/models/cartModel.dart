import 'package:flutter/material.dart';
import 'package:map_project/models/productModel.dart';

class Cart extends ChangeNotifier {
  Map<Product, int> products = {};

  void addProduct(Product product) {
    if (products.containsKey(product)) {
      products[product] = (products[product] ?? 0) + 1;
    } else {
      products[product] = 1;
    }

    notifyListeners(); // Notify listeners about the change
  }

  void increaseProductQuantity(Product product) {
    products[product] = (products[product] ?? 0) + 1;
    notifyListeners();
  }

  void decreaseProductQuantity(Product product) {
    if (products[product]! > 1) {
      products[product] = (products[product] ?? 0) - 1;
    } else {
      products.remove(product);
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;
    products.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  // Other cart-related methods...
}
