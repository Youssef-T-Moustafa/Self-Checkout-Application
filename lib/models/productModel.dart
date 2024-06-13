class Product {
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final double price;
  final double discountedPrice;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.discountedPrice,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name; // compare other properties as needed
  }

  @override
  int get hashCode => name.hashCode;
}
