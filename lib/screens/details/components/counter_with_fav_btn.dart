import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_bloc.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_event.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_state.dart';
import 'package:shop_app/main.dart';

import 'cart_counter.dart';

class CounterWithFavBtn extends StatelessWidget {
  const CounterWithFavBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const CartCounter(),
        BlocBuilder<DetailProdBloc, DetailProdState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context
                    .read<DetailProdBloc>()
                    .add(FvrtProduct(!(state.isFvrt ?? false)));
              },
              child: Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF6464),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    (state.isFvrt ?? false)
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
