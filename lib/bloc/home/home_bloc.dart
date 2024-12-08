import 'package:bloc/bloc.dart';
import 'package:shop_app/bloc/home/home_event.dart';
import 'package:shop_app/bloc/home/home_state.dart';
import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/repo/product_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ProductRepo productRepo = ProductRepo();

  HomeBloc() : super(HomeState()) {
    on<FetchHomeProduct>(_fetchHomeProduct);
    on<FetchUserCart>(_fetchUserCart);
    on<UpdateUserCart>(_addMoreToCart);
  }

  Future<void> _fetchHomeProduct(
      FetchHomeProduct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading));
    await productRepo.getProductsAll().then((value) {
      emit(state.copyWith(
          loadingStatus: LoadingStatus.success, productData: value));
    }, onError: (error) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    });
  }

  Future<void> _fetchUserCart(
      FetchUserCart event, Emitter<HomeState> emit) async {
    await productRepo.getUserCart().then((value) {
      emit(state.copyWith(userCart: value));
    }, onError: (error) {});
  }

  Future<void> _addMoreToCart(
      UpdateUserCart event, Emitter<HomeState> emit) async {
    List<CartModel> cartData = List.from(state.userCart ?? []);
    cartData.add(event.cartModel);
    emit(state.copyWith(userCart: cartData));
  }
}
