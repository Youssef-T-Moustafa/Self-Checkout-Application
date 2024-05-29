import 'package:flutter/material.dart';
import 'package:map_project/models/productModel.dart';


class Cart extends ChangeNotifier {
  //List<Tuple2<Product, int>> products = [];
  Map<Product, int> products = {};

  void addProduct(Product product) {
    // ignore: collection_methods_unrelated_type
    if (products.containsKey(product)) {
      products[product] = (products[product] ?? 0) + 1;
    } else {
      products[product] = 1;
    }

    notifyListeners(); // Notify listeners about the change
  }

  void increaseProductQuantity(Product product){
    products[product] = (products[product] ?? 0) + 1;
    notifyListeners();
  }
  void decreaseProductQuantity(Product product){
    if (products[product]! > 1) {
      products[product] = (products[product] ?? 0) - 1;
    } else {
      products.remove(product);
    }
    notifyListeners();
  }

  // Other cart-related methods...
}
