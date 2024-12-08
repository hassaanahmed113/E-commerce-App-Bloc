import 'package:flutter/material.dart';
import 'package:shop_app/models/product_model.dart';

import '../../../constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: kDefaultPaddin / 2),
          Text(
            product.category ?? "",
            style: const TextStyle(color: Colors.black),
          ),
          Text(
            product.title ?? "",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${product.price}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: kDefaultPaddin),
              Center(
                child: SizedBox(
                  height: 300,
                  width: 240,
                  child: Image.network(
                    product.image ?? '',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
