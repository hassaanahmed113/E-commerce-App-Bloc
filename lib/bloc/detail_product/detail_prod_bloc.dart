import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_event.dart';
import 'package:shop_app/bloc/detail_product/detail_prod_state.dart';
import 'package:shop_app/bloc/home/home_event.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/repo/single_product_repo.dart';

class DetailProdBloc extends Bloc<DetailProdEvent, DetailProdState> {
  SingleProductRepo singleProductRepo = SingleProductRepo();
  DetailProdBloc() : super(DetailProdState()) {
    on<FetchSingleProduct>(_fetchSingleProduct);
    on<PutSingleProductCart>(_putSingleProductCart);
    on<DefaultLoadingCart>(_defaultLoadingCart);
    on<FvrtProduct>(_fvrtProduct);
    on<CounterProduct>(_counterProduct);
  }

  Future<void> _fetchSingleProduct(
      FetchSingleProduct event, Emitter<DetailProdState> emit) async {
    emit(state.copyWith(detailLoadingStatus: DetailLoadingStatus.loading));

    await singleProductRepo.singleProductApi(event.productId).then((value) {
      emit(state.copyWith(
          detailLoadingStatus: DetailLoadingStatus.success,
          singleProduct: value));
    }, onError: (error) {
      emit(state.copyWith(detailLoadingStatus: DetailLoadingStatus.failure));
    });
  }

  Future<void> _putSingleProductCart(
      PutSingleProductCart event, Emitter<DetailProdState> emit) async {
    emit(state.copyWith(cartAddLoadingStatus: CartAddLoadingStatus.loading));
    await Future.delayed(
      const Duration(seconds: 2),
      () async {
        await singleProductRepo
            .singleProductApi(
          event.productId,
        )
            .then((value) {
          emit(state.copyWith(
            cartAddLoadingStatus: CartAddLoadingStatus.success,
          ));
          event.homeBloc.add(UpdateUserCart(CartModel(
              id: event.productId,
              userId: 1,
              date: DateTime(DateTime.april),
              products: [Product(productId: event.productId, quantity: 1)])));
        }, onError: (error) {
          emit(state.copyWith(
              cartAddLoadingStatus: CartAddLoadingStatus.failure));
        });
      },
    );
  }

  void _defaultLoadingCart(
      DefaultLoadingCart event, Emitter<DetailProdState> emit) {
    emit(state.copyWith(cartAddLoadingStatus: CartAddLoadingStatus.initial));
  }

  void _fvrtProduct(FvrtProduct event, Emitter<DetailProdState> emit) {
    emit(state.copyWith(isFvrt: event.isFvrt));
  }

  void _counterProduct(CounterProduct event, Emitter<DetailProdState> emit) {
    final currentCount = state.count ?? 0;
    if (event.type == 'plus') {
      emit(state.copyWith(count: currentCount + 1));
    } else if (event.type == 'minus') {
      if (currentCount > 1) {
        emit(state.copyWith(count: currentCount - 1));
      }
    } else {
      emit(state.copyWith(count: event.count));
    }
  }
}
