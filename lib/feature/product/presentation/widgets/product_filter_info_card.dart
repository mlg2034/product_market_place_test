import 'package:flutter/material.dart';
import 'package:product_shop_test_task/feature/product/logic/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductFilterInfoCard extends StatelessWidget {
  const ProductFilterInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        String filterText = 'Все товары';

        switch (provider.selectedFilterType) {
          case FilterType.category:
            filterText = 'Категория: ${provider.selectedCategory}';
            break;
          case FilterType.priceRange:
            filterText =
                'Цена: \$${provider.minPrice.toStringAsFixed(2)}-\$${provider.maxPrice.isInfinite ? 'max' : provider.maxPrice.toStringAsFixed(2)}';
            break;
          case FilterType.rating:
            filterText = 'Рейтинг: ${provider.minRating.toStringAsFixed(2)}+';
            break;
          case FilterType.all:
            filterText = 'Все товары';
            break;
        }

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  filterText,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (provider.selectedFilterType != FilterType.all)
                TextButton(
                  onPressed: () => provider.clearFilters(),
                  child: Text(
                    'Сбросить',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
