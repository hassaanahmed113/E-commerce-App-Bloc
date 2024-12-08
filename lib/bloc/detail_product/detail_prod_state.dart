import 'package:equatable/equatable.dart';
import 'package:shop_app/models/product_model.dart';

enum DetailLoadingStatus { loading, success, failure }

enum CartAddLoadingStatus { loading, success, failure, initial }

// ignore: must_be_immutable
class DetailProdState extends Equatable {
  ProductModel? singleProduct;
  DetailLoadingStatus? detailLoadingStatus;
  CartAddLoadingStatus? cartAddLoadingStatus;
  int? productId;
  bool? isFvrt;
  int? count;
  String? type;
  DetailProdState(
      {this.singleProduct,
      this.detailLoadingStatus = DetailLoadingStatus.loading,
      this.cartAddLoadingStatus = CartAddLoadingStatus.initial,
      this.isFvrt = false,
      this.count = 1,
      this.type = '',
      this.productId = 0});

  DetailProdState copyWith(
      {ProductModel? singleProduct,
      DetailLoadingStatus? detailLoadingStatus,
      CartAddLoadingStatus? cartAddLoadingStatus,
      bool? isFvrt,
      int? count,
      String? type,
      int? productId}) {
    return DetailProdState(
        detailLoadingStatus: detailLoadingStatus ?? this.detailLoadingStatus,
        cartAddLoadingStatus: cartAddLoadingStatus ?? this.cartAddLoadingStatus,
        productId: productId ?? this.productId,
        isFvrt: isFvrt ?? this.isFvrt,
        count: count ?? this.count,
        type: type ?? this.type,
        singleProduct: singleProduct ?? this.singleProduct);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        singleProduct,
        detailLoadingStatus,
        productId,
        cartAddLoadingStatus,
        count,
        isFvrt,
        type
      ];
}
