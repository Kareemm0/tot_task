import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tot_task_application/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:tot_task_application/features/cart/presentation/cubit/cart_state.dart';
import '../../../../core/widget/custom_app_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..products(),
      child: BlocConsumer<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Column(
                spacing: 16,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cubit.cartService.items.length,
                      itemBuilder: (context, index) {
                        final item = cubit.cartService.items[index];
                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text('Quantity: ${item.quantity}'),
                          trailing:
                              Text('\$${item.product.price * item.quantity}'),
                          onTap: () {
                            cubit.remove(item.product.id);
                          },
                        );
                      },
                    ),
                  ),
                  TextField(
                    controller: cubit.promoCodeController,
                    decoration: InputDecoration(
                      labelText: 'Enter Promo Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  CustomAppButton(
                    text: "Apply Discount",
                    onPressed: cubit.applyDiscount,
                    textColor: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Total Price: \$${cubit.cartService.getTotalPrice().toStringAsFixed(2)}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
