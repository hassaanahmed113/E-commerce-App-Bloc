import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_bloc.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';
import 'constants.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocProvider(
        create: (context) => DetailProdBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Flutter Way',
          theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
