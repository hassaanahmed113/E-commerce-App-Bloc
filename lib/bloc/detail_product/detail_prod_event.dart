import 'package:equatable/equatable.dart';
import 'package:shop_app/bloc/home/home_bloc.dart';

abstract class DetailProdEvent extends Equatable {
  const DetailProdEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FetchSingleProduct extends DetailProdEvent {
  final int productId;
  const FetchSingleProduct(this.productId);

  @override
  // TODO: implement props
  List<Object?> get props => [productId];
}

class PutSingleProductCart extends DetailProdEvent {
  final int productId;
  final int quantity;
  final HomeBloc homeBloc;
  const PutSingleProductCart(this.productId, this.quantity, this.homeBloc);

  @override
  // TODO: implement props
  List<Object?> get props => [productId, quantity, homeBloc];
}

class DefaultLoadingCart extends DetailProdEvent {}

class FvrtProduct extends DetailProdEvent {
  final bool isFvrt;
  const FvrtProduct(
    this.isFvrt,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [isFvrt];
}

class CounterProduct extends DetailProdEvent {
  final int? count;
  final String type;
  const CounterProduct({this.count, required this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [count, type];
}
