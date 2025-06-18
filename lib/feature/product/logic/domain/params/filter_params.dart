
import '../../provider/product_provider.dart';

class FilterParams {
  FilterType selectedFilterType;
  String selectedCategory;
  double minPrice;
  double maxPrice;
  double minRating;
  double currentMinPrice;
  double currentMaxPrice;
  double currentMinRating;
  double currentMaxRating;

  FilterParams({
    this.selectedFilterType = FilterType.all,
    this.selectedCategory = '',
    this.minPrice = 0,
    this.maxPrice = 3000,
    this.minRating = 0,
    this.currentMinPrice = 0,
    this.currentMaxPrice = 3000,
    this.currentMinRating = 0,
    this.currentMaxRating = 5.0,
  });

  FilterParams copyWith({
    FilterType? selectedFilterType,
    String? selectedCategory,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    double? currentMinPrice,
    double? currentMaxPrice,
    double? currentMinRating,
    double? currentMaxRating,
  }) {
    return FilterParams(
      selectedFilterType: selectedFilterType ?? this.selectedFilterType,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      currentMinPrice: currentMinPrice ?? this.currentMinPrice,
      currentMaxPrice: currentMaxPrice ?? this.currentMaxPrice,
      currentMinRating: currentMinRating ?? this.currentMinRating,
      currentMaxRating: currentMaxRating ?? this.currentMaxRating,
    );
  }

  void reset(double maxProductPrice) {
    selectedFilterType = FilterType.all;
    selectedCategory = '';
    minPrice = 0;
    maxPrice = maxProductPrice;
    minRating = 0;
    currentMinPrice = 0;
    currentMaxPrice = maxProductPrice;
    currentMinRating = 0;
    currentMaxRating = 5.0;
  }
}
