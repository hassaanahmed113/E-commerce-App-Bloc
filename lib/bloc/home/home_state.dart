import 'package:equatable/equatable.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/product_model.dart';

enum LoadingStatus { loading, success, failure }

class HomeState extends Equatable {
  List<ProductModel>? productData;
  LoadingStatus? loadingStatus;
  List<CartModel>? userCart;
  CartModel? addMoreToCart;

  HomeState(
      {this.productData,
      this.loadingStatus,
      this.userCart,
      this.addMoreToCart});

  HomeState copyWith(
      {List<ProductModel>? productData,
      LoadingStatus? loadingStatus,
      List<CartModel>? userCart,
      CartModel? addMoreToCart}) {
    return HomeState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        userCart: userCart ?? this.userCart,
        productData: productData ?? this.productData,
        addMoreToCart: addMoreToCart ?? this.addMoreToCart);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [productData, loadingStatus, userCart, addMoreToCart];
}
