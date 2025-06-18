import 'package:product_shop_test_task/feature/product/data/data_source/product_data_source.dart';
import 'package:product_shop_test_task/feature/product/data/dto/product_dto.dart';

class ProductRepository {
  //Можно использовать DI(get_it , inheretedWidget) и инициализировать через конструктор

  final ProductDataSource _dataSource = ProductDataSource();

  //Для репозитория нужно создать отдельные Model и через toModel метод
  //Сделать map с dto to model
  Future<List<ProductDto>> getProductList() async =>
      await _dataSource.getProductList();
}
