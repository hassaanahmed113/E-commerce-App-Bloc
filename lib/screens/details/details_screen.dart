import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_bloc.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_event.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_state.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';
import 'package:shop_app/bloc/home/home_state.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/product_model.dart';

import '../../constants.dart';
import 'components/add_to_cart.dart';
import 'components/color_and_size.dart';
import 'components/counter_with_fav_btn.dart';
import 'components/description.dart';
import 'components/product_title_with_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DetailProdBloc>().add(FetchSingleProduct(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // each product have a color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {
            Navigator.pop(context);
            context.read<DetailProdBloc>().add(DefaultLoadingCart());
            context.read<DetailProdBloc>().add(const FvrtProduct(false));
            context.read<DetailProdBloc>().add(
                  const CounterProduct(type: '', count: 1),
                );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  "assets/icons/cart.svg",
                  colorFilter:
                      const ColorFilter.mode(kTextColor, BlendMode.srcIn),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if ((state.userCart?.length ?? 0) > 0) {
                      return Positioned(
                        right: 0,
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            state.userCart?.length.toString() ?? "0",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              ],
            ),
          ),
          const SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: size.height,
                child: BlocBuilder<DetailProdBloc, DetailProdState>(
                  builder: (context, state) {
                    if (state.detailLoadingStatus ==
                        DetailLoadingStatus.loading) {
                      return const Center(
                          child: SpinKitFadingCircle(
                        color: Colors.blue,
                      ));
                    } else if (state.detailLoadingStatus ==
                        DetailLoadingStatus.failure) {
                      return const Text('No found data');
                    } else {
                      return Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.3),
                            padding: EdgeInsets.only(
                              top: size.height * 0.12,
                              left: kDefaultPaddin,
                              right: kDefaultPaddin,
                            ),
                            // height: 500,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                ColorAndSize(
                                    product:
                                        state.singleProduct ?? ProductModel()),
                                const SizedBox(height: kDefaultPaddin / 2),
                                Description(
                                    product:
                                        state.singleProduct ?? ProductModel()),
                                const SizedBox(height: kDefaultPaddin / 2),
                                const CounterWithFavBtn(),
                                const SizedBox(height: kDefaultPaddin / 2),
                                AddToCart(
                                    product:
                                        state.singleProduct ?? ProductModel())
                              ],
                            ),
                          ),
                          ProductTitleWithImage(
                              product: state.singleProduct ?? ProductModel())
                        ],
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
