import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_bloc.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_event.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_state.dart';
import 'package:shop_app/main.dart';

import '../../../constants.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            onPressed: () {
              context
                  .read<DetailProdBloc>()
                  .add(const CounterProduct(type: 'minus'));
            },
            child: const Icon(Icons.remove),
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
            child: BlocBuilder<DetailProdBloc, DetailProdState>(
              builder: (context, state) => Text(
                // if our item is less  then 10 then  it shows 01 02 like that
                state.count.toString().padLeft(2, "0"),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )),
        SizedBox(
          width: 40,
          height: 32,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            onPressed: () {
              context
                  .read<DetailProdBloc>()
                  .add(const CounterProduct(type: 'plus'));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
