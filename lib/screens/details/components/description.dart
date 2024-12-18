import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        product.description ?? "",
        style: const TextStyle(height: 1.5),
      ),
    );
  }
}
