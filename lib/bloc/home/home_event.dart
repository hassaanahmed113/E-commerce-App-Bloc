import 'package:equatable/equatable.dart';
import 'package:shop_app/models/cart_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchHomeProduct extends HomeEvent {}

class FetchUserCart extends HomeEvent {}

class UpdateUserCart extends HomeEvent {
  final CartModel cartModel;

  const UpdateUserCart(this.cartModel);

  @override
  // TODO: implement props
  List<Object?> get props => [cartModel];
}
