import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_bloc.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_event.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_state.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';
import 'package:shop_app/models/product_model.dart';
import '../../../constants.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
              ),
              onPressed: () {},
            ),
          ),
          Expanded(child: BlocBuilder<DetailProdBloc, DetailProdState>(
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: () {
                    if (state.cartAddLoadingStatus ==
                        CartAddLoadingStatus.success) {
                    } else {
                      context.read<DetailProdBloc>().add(PutSingleProductCart(
                          product.id ?? 0, 1, context.read<HomeBloc>()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.cartAddLoadingStatus ==
                            CartAddLoadingStatus.success
                        ? Colors.grey
                        : Colors.blue,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  child: BlocBuilder<DetailProdBloc, DetailProdState>(
                    builder: (context, state) {
                      if (state.cartAddLoadingStatus ==
                          CartAddLoadingStatus.loading) {
                        return const Center(
                            child: SpinKitFadingCircle(
                          color: Colors.white,
                        ));
                      } else if (state.cartAddLoadingStatus ==
                          CartAddLoadingStatus.success) {
                        return Text(
                          "Added".toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      } else if (state.cartAddLoadingStatus ==
                          CartAddLoadingStatus.failure) {
                        return Text(
                          "issue".toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      } else if (state.cartAddLoadingStatus ==
                          CartAddLoadingStatus.initial) {
                        return Text(
                          "Add to cart".toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      } else {
                        return const Text("");
                      }
                    },
                  ));
            },
          )),
        ],
      ),
    );
  }

  String getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }
}
