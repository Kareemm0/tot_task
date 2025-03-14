import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/service/cart_service.dart';
import '../../data/product_model.dart';
import '../../source/impl/discount_source_impl.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  final TextEditingController promoCodeController = TextEditingController();

  final CartService cartService = CartService();

  void applyDiscount() {
    final promoCode = promoCodeController.text;
    if (promoCode.isNotEmpty) {
      cartService.setDiscount(DiscountSourceImpl(promoCode));
      emit(ApplyDiscountChangesState());
    }
  }

  void products() {
    cartService
        .addProduct(ProductModel(id: '1', name: 'Product A', price: 100));
    cartService
        .addProduct(ProductModel(id: '2', name: 'Product B', price: 200));
    cartService
        .addProduct(ProductModel(id: '3', name: 'Product C', price: 200));
    cartService
        .addProduct(ProductModel(id: '4', name: 'Product D', price: 200));
  }

  void remove(String id) {
    cartService.removeProduct(id);
    emit(RemoveItemFromCartState());
  }
}
