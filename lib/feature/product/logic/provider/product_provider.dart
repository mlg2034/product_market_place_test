import 'package:flutter/material.dart';
import 'package:product_shop_test_task/feature/product/logic/domain/params/filter_params.dart';
import '../../data/dto/product_dto.dart';
import '../../data/repository/product_repository.dart';

//Использовал Provider так как функционал достаточно легкий и не требует реактивности

//Также не хотел нагружать проект посторонними пакетами

//Фильтрацию можно было также реализовать через реактивность Stream

enum FilterType { all, category, priceRange, rating }

class ProductProvider with ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  
  List<ProductDto> _products = [];
  List<ProductDto> _filteredProducts = [];
  bool _isLoading = false;
  String? _error;

  final FilterParams _filterParams = FilterParams();
  
  List<ProductDto> get products => _products;
  List<ProductDto> get filteredProducts => _filteredProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  FilterType get selectedFilterType => _filterParams.selectedFilterType;
  String get selectedCategory => _filterParams.selectedCategory;
  double get minPrice => _filterParams.minPrice;
  double get maxPrice => _filterParams.maxPrice;
  double get minRating => _filterParams.minRating;
  double get currentMinPrice => _filterParams.currentMinPrice;
  double get currentMaxPrice => _filterParams.currentMaxPrice;
  double get currentMinRating => _filterParams.currentMinRating;
  double get currentMaxRating => _filterParams.currentMaxRating;
  
  double get maxProductPrice => _products.isEmpty ? 3000 : _products.map((p) => p.price).reduce((a, b) => a > b ? a : b);
  double get maxProductRating => 5.0;
  
  List<String> get categories {
    final cats = _products.map((p) => p.category).toSet().toList();
    cats.sort();
    return cats;
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      final products = await _repository.getProductList();
      _products = products;
      _filteredProducts = products;
      
      if (_products.isNotEmpty) {
        final maxPrice = _products.map((p) => p.price).reduce((a, b) => a > b ? a : b);
        if (_filterParams.currentMaxPrice > maxPrice) {
          _filterParams.currentMaxPrice = maxPrice;
        }
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Ошибка загрузки товаров: ${e.toString()}';
      notifyListeners();
    }
  }

  void filterByCategory(String category) {
    _filterParams.selectedFilterType = FilterType.category;
    _filterParams.selectedCategory = category;
    _applyFilters();
  }
  
  void filterByPriceRange(double min, double max) {
    _filterParams.selectedFilterType = FilterType.priceRange;
    _filterParams.minPrice = min;
    _filterParams.maxPrice = max;
    _applyFilters();
  }
  
  void filterByRating(double minRating) {
    _filterParams.selectedFilterType = FilterType.rating;
    _filterParams.minRating = minRating;
    _applyFilters();
  }
  
  void updatePriceRange(double min, double max) {
    _filterParams.currentMinPrice = min;
    _filterParams.currentMaxPrice = max;
    _filterParams.selectedFilterType = FilterType.priceRange;
    _filterParams.minPrice = min;
    _filterParams.maxPrice = max;
    _applyFilters();
  }
  
  void updateRatingRange(double min, double max) {
    _filterParams.currentMinRating = min;
    _filterParams.currentMaxRating = max;
    _filterParams.selectedFilterType = FilterType.rating;
    _filterParams.minRating = min;
    _applyFilters();
  }
  
  void clearFilters() {
    _filterParams.reset(maxProductPrice);
    _filteredProducts = _products;
    notifyListeners();
  }
  
  void _applyFilters() {
    List<ProductDto> filtered = _products;
    
    switch (_filterParams.selectedFilterType) {
      case FilterType.category:
        filtered = _products.where((p) => p.category == _filterParams.selectedCategory).toList();
        break;
      case FilterType.priceRange:
        filtered = _products.where((p) => p.price >= _filterParams.minPrice && p.price <= _filterParams.maxPrice).toList();
        break;
      case FilterType.rating:
        filtered = _products.where((p) => p.rating >= _filterParams.minRating && p.rating <= _filterParams.currentMaxRating).toList();
        break;
      case FilterType.all:
        filtered = _products;
        break;
    }
    
    _filteredProducts = filtered;
    notifyListeners();
  }
} 