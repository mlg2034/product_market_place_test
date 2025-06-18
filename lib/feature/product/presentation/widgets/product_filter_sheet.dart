import 'package:flutter/material.dart';
import 'package:product_shop_test_task/feature/product/logic/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductFilterSheet extends StatefulWidget {
  const ProductFilterSheet({super.key});

  @override
  State<ProductFilterSheet> createState() => _ProductFilterSheetState();

  static view({required BuildContext context}) => showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (context) => ProductFilterSheet(),
  );
}

class _ProductFilterSheetState extends State<ProductFilterSheet> {
  late double _minPrice;
  late double _maxPrice;
  late double _minRating;
  late double _maxRating;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ProductProvider>();
    final maxProductPrice = provider.maxProductPrice;
    
    _minPrice = provider.currentMinPrice;
    _maxPrice = provider.currentMaxPrice > maxProductPrice ? maxProductPrice : provider.currentMaxPrice;
    _minRating = provider.currentMinRating;
    _maxRating = provider.currentMaxRating;
    
    if (_maxPrice > maxProductPrice) _maxPrice = maxProductPrice;
    if (_minPrice > _maxPrice) _minPrice = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        final maxProductPrice = provider.maxProductPrice;

        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: 40,
                  height: 4,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Фильтры',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                _buildCategoriesSection(provider),
                const SizedBox(height: 24),

                _buildPriceSection(provider, maxProductPrice),
                const SizedBox(height: 24),

                _buildRatingSection(provider),
                const SizedBox(height: 32),

                _buildActionButtons(provider),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoriesSection(ProductProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Категории',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              provider.categories.map((category) {
                final isSelected = provider.selectedCategory == category;
                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  selectedColor: Colors.blue[100],
                  checkmarkColor: Colors.blue[800],
                  backgroundColor: Colors.grey[100],
                  onSelected: (selected) {
                    if (selected) {
                      provider.filterByCategory(category);
                    } else {
                      provider.clearFilters();
                    }
                  },
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceSection(ProductProvider provider, double maxProductPrice) {
    final validMaxPrice = maxProductPrice > 0 ? maxProductPrice : 3000.0;
    
    var validMinPrice = _minPrice;
    var validMaxPrice2 = _maxPrice;
    
    if (validMinPrice < 0) validMinPrice = 0;
    if (validMinPrice > validMaxPrice) validMinPrice = 0;
    if (validMaxPrice2 > validMaxPrice) validMaxPrice2 = validMaxPrice;
    if (validMaxPrice2 < validMinPrice) validMaxPrice2 = validMinPrice;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Диапазон цен',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${validMinPrice.toInt()} - \$${validMaxPrice2.toInt()}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        Stack(
          children: [
            SizedBox(
              height: 6,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            LinearProgressIndicator(
              value: validMaxPrice > 0 ? (validMaxPrice2 - validMinPrice) / validMaxPrice : 0,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green[600]!),
              minHeight: 6,
            ),
          ],
        ),

        const SizedBox(height: 16),

        RangeSlider(
          values: RangeValues(validMinPrice, validMaxPrice2),
          min: 0,
          max: validMaxPrice,
          divisions: 100,
          activeColor: Colors.green[600],
          inactiveColor: Colors.grey[300],
          labels: RangeLabels(
            '\$${validMinPrice.toInt()}',
            '\$${validMaxPrice2.toInt()}',
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _minPrice = values.start;
              _maxPrice = values.end;
            });
          },
          onChangeEnd: (RangeValues values) {
            provider.updatePriceRange(values.start, values.end);
          },
        ),
      ],
    );
  }

  Widget _buildRatingSection(ProductProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Диапазон рейтинга',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${_minRating.toStringAsFixed(1)} - ${_maxRating.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange[700],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        Stack(
          children: [
            SizedBox(
              height: 6,

              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            LinearProgressIndicator(
              value: (_maxRating - _minRating) / 5.0,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[600]!),
              minHeight: 6,
            ),
          ],
        ),

        const SizedBox(height: 16),

        RangeSlider(
          values: RangeValues(_minRating, _maxRating),
          min: 0,
          max: 5.0,
          divisions: 50,
          activeColor: Colors.orange[600],
          inactiveColor: Colors.grey[300],
          labels: RangeLabels(
            _minRating.toStringAsFixed(1),
            _maxRating.toStringAsFixed(1),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _minRating = values.start;
              _maxRating = values.end;
            });
          },
          onChangeEnd: (RangeValues values) {
            provider.updateRatingRange(values.start, values.end);
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(ProductProvider provider) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              provider.clearFilters();
              setState(() {
                _minPrice = 0;
                _maxPrice = provider.maxProductPrice;
                _minRating = 0;
                _maxRating = 5.0;
              });
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Сбросить',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Применить',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
