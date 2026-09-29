import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_views.dart';
import '../../../products/presentation/widgets/product_card.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';

/// Second tab: products the user has hearted. Reuses [ProductCard] so
/// favoriting/adding-to-cart behaves identically to the Home grid.
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Favorites', style: AppTextStyles.heading),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final favorites = state.favoriteProducts;
                  if (favorites.isEmpty) {
                    return const EmptyView(
                      icon: Icons.favorite_border_rounded,
                      message: 'No favorites yet.\nTap the heart on any product.',
                    );
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.only(bottom: 110, top: 4),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.62,
                    ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) => ProductCard(product: favorites[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
