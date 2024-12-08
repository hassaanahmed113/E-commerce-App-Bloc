// Define a Product model with only productId and quantity
class Product {
  final int productId;
  final int quantity;

  Product({
    required this.productId,
    required this.quantity,
  });

  // Factory method to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  // Method to convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}

// Define an Order model
class CartModel {
  final int id;
  final int userId;
  final DateTime date;
  final List<Product> products;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  // Factory method to create Order from JSON
  factory CartModel.fromJson(Map<String, dynamic> json) {
    var productList = (json['products'] as List)
        .map((product) => Product.fromJson(product))
        .toList();

    return CartModel(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: productList,
    );
  }

  // Method to convert Order to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
