import 'package:tot_task_application/features/cart/data/cart_model.dart';
import 'package:tot_task_application/features/cart/data/product_model.dart';
import 'package:tot_task_application/features/cart/source/base/discount_source.dart';

class CartService {
  final List<CartModel> _items = [];
  DiscountSource? _source;

  void setDiscount(DiscountSource source) {
    _source = source;
  }

  void addProduct(ProductModel product) {
    final existingItem = _items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () =>
          CartModel(product: ProductModel(id: '', name: '', price: 0)),
    );

    if (existingItem.product.id.isNotEmpty) {
      existingItem.quantity++;
    } else {
      _items.add(CartModel(product: product));
    }
  }

  void removeProduct(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  double getTotalPrice() {
    double totalPrice = _items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    if (_source != null) {
      return _source!.applyDiscount(totalPrice);
    }

    return totalPrice;
  }

  List<CartModel> get items => _items;
}
