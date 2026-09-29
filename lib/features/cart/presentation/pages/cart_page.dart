import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/state_views.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/cart_item_card.dart';

/// Third tab: items added to the cart, with quantity controls, removal,
/// a running total, and a mock checkout action.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Cart', style: AppTextStyles.heading),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state.cartItems.isEmpty) {
                    return const EmptyView(
                      icon: Icons.shopping_cart_outlined,
                      message: 'Your cart is empty.',
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 4),
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) => CartItemCard(item: state.cartItems[index]),
                  );
                },
              ),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state.cartItems.isEmpty) return const SizedBox.shrink();
                return GlassContainer(
                  borderRadius: 20,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total', style: AppTextStyles.title),
                          Text('\$${state.totalPrice.toStringAsFixed(2)}', style: AppTextStyles.price),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CartCubit>().clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Order placed successfully!')),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 6),
                            child: Text('Checkout'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
