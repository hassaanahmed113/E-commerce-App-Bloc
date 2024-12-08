import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';
import 'package:shop_app/bloc/home/home_event.dart';
import 'package:shop_app/bloc/home/home_state.dart';
import 'package:shop_app/models/product_model.dart';
import '../../constants.dart';

import '../details/details_screen.dart';
import 'components/item_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(FetchHomeProduct());
    context.read<HomeBloc>().add(FetchUserCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {},
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
                    log(state.userCart?.length.toString() ?? "J");
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Ecommerce App",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // const Categories(),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.loadingStatus == LoadingStatus.loading) {
                      return const Center(
                          child: SpinKitFadingCircle(
                        color: Colors.blue,
                      ));
                    } else if (state.loadingStatus == LoadingStatus.failure) {
                      return const Text('No found data');
                    } else {
                      return GridView.builder(
                        itemCount: state.productData?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPaddin,
                          crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) => ItemCard(
                            product:
                                state.productData?[index] ?? ProductModel(),
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    productId:
                                        state.productData?[index].id ?? 0,
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
