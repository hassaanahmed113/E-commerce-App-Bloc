import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/product_model.dart';

class ProductRepo {
  Future<List<ProductModel>> getProductsAll() async {
    try {
      // Fetch the data
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        return jsonData.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to load products, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<List<CartModel>> getUserCart() async {
    try {
      // Fetch the data
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/carts/user/1'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        log(jsonData.toString());
        return jsonData.map((e) => CartModel.fromJson(e)).toList();
      } else {
        throw Exception(
            'Failed to load products, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      print('Error fetching products: $e');
      return [];
    }
  }
}
