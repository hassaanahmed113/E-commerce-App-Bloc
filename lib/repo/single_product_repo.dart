import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/product_model.dart';

class SingleProductRepo {
  Future<ProductModel> singleProductApi(int productId) async {
    try {
      // Fetch the data
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products/$productId'));

      if (response.statusCode == 200) {
        final dynamic jsonData = json.decode(response.body);

        return ProductModel.fromJson(jsonData);
      } else {
        throw Exception(
            'Failed to load product, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      debugPrint('Error fetching product: $e');
      return ProductModel();
    }
  }

  Future<void> putProductCart(int productId, int quantity) async {
    try {
      final response = await http.put(
        Uri.parse('https://fakestoreapi.com/carts/user/1'),
        body: jsonEncode({
          'userId': 1,
          'date': '2019-12-10',
          'products': [
            {'productId': 1, 'quantity': 3}
          ]
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        log(jsonData.toString());
      } else {
        throw Exception(
            'Failed to load products, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      debugPrint('Error fetching products puttingg: $e');
    }
  }
}
