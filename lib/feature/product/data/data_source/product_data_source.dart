import 'package:product_shop_test_task/app/services/api_client_service.dart';
import 'package:product_shop_test_task/feature/product/data/dto/product_dto.dart';

class ProductDataSource {
  //Можно использовать DI(get_it , inheretedWidget) и инициализировать через конструктор

  final ApiClientService _clientService = ApiClientService();

  Future<List<ProductDto>> getProductList() => _clientService.dio
      .get('products')
      .then((value) => ProductDto.fromJsonDtoList(value.data['products']));
}
