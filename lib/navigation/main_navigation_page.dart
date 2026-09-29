import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/gradient_background.dart';
import '../features/cart/presentation/cubit/cart_cubit.dart';
import '../features/cart/presentation/cubit/cart_state.dart';
import '../features/cart/presentation/pages/cart_page.dart';
import '../features/favorites/presentation/pages/favorites_page.dart';
import '../features/products/presentation/pages/home_page.dart';
import 'widgets/glass_bottom_nav_bar.dart';

/// App shell: gradient backdrop + the 3 tabs (Home, Favorites, Cart)
/// behind a floating glass bottom nav bar.
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  static const _pages = [HomePage(), FavoritesPage(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            return GlassBottomNavBar(
              selectedIndex: _selectedIndex,
              cartBadgeCount: cartState.itemCount,
              onItemSelected: (index) => setState(() => _selectedIndex = index),
            );
          },
        ),
      ),
    );
  }
}
