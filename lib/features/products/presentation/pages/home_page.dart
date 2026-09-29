import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/state_views.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import '../widgets/category_filter.dart';
import '../widgets/product_card.dart';
import '../widgets/search_field.dart';

/// Main tab: search + category filter + a product grid pulled from
/// both source APIs.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Discover', style: AppTextStyles.heading),
            const SizedBox(height: 4),
            Text('Find products you will love', style: AppTextStyles.body),
            const SizedBox(height: 16),
            SearchField(onChanged: (query) => context.read<ProductCubit>().search(query)),
            const SizedBox(height: 14),
            BlocBuilder<ProductCubit, ProductState>(
              buildWhen: (previous, current) =>
                  previous.categories != current.categories ||
                  previous.selectedCategory != current.selectedCategory,
              builder: (context, state) {
                return CategoryFilter(
                  categories: state.categories,
                  selected: state.selectedCategory,
                  onSelected: (category) =>
                      context.read<ProductCubit>().filterByCategory(category),
                );
              },
            ),
            const SizedBox(height: 14),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ProductStatus.initial:
                    case ProductStatus.loading:
                      return const LoadingView();
                    case ProductStatus.error:
                      return ErrorView(
                        message: state.errorMessage ?? 'Something went wrong.',
                        onRetry: () => context.read<ProductCubit>().loadProducts(),
                      );
                    case ProductStatus.loaded:
                      final products = state.visibleProducts;
                      if (products.isEmpty) {
                        return const EmptyView(
                          icon: Icons.search_off_rounded,
                          message: 'No products match your search.',
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () => context.read<ProductCubit>().loadProducts(),
                        child: GridView.builder(
                          padding: const EdgeInsets.only(bottom: 110, top: 4),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.62,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) => ProductCard(product: products[index]),
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
