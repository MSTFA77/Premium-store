import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/favorites/presentation/cubit/favorites_cubit.dart';
import 'features/products/presentation/cubit/product_cubit.dart';
import 'navigation/main_navigation_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const PrimeShopApp());
}

class PrimeShopApp extends StatelessWidget {
  const PrimeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(create: (_) => getIt<ProductCubit>()..loadProducts()),
        BlocProvider<FavoritesCubit>(create: (_) => getIt<FavoritesCubit>()),
        BlocProvider<CartCubit>(create: (_) => getIt<CartCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'prime Shop',
        theme: AppTheme.light,
        home: const MainNavigationPage(),
      ),
    );
  }
}
