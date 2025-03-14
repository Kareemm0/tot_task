import 'package:tot_task_application/features/cart/source/base/discount_source.dart';

class DiscountSourceImpl implements DiscountSource {
  final String promoCode;

  DiscountSourceImpl(this.promoCode);

  @override
  double applyDiscount(double totalPrice) {
    if (promoCode == "discount") {
      //! 10% discount
      return totalPrice * 0.9;
    }
    return totalPrice;
  }
}
