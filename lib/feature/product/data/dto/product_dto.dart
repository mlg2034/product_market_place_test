import 'package:product_shop_test_task/feature/product/data/dto/review_dto.dart';

import 'dimensions_dto.dart';
import 'meta_dto.dart';

//Можно реализавать также через пакеты для серилизации freezed , json_serialization
class ProductDto {
  const ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviewListDto,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final double weight;
  final DimensionsDto dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ReviewDto> reviewListDto;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final MetaDto meta;
  final List<String> images;
  final String thumbnail;

  //Можно было бы добавить ParseUtils для лучшей серилизации , но есть ограничение по времени

  factory ProductDto.fromJson(Map<String, dynamic> json) => ProductDto(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    price: (json['price'] as num).toDouble(),
    discountPercentage: (json['discountPercentage'] as num).toDouble(),
    rating: (json['rating'] as num).toDouble(),
    stock: json['stock'] as int,
    tags: List<String>.from(json['tags'] ?? []),
    brand: json['brand'] as String? ?? 'Unknown Brand',
    sku: json['sku'] as String,
    weight: (json['weight'] as num).toDouble(),
    dimensions: DimensionsDto.fromJson(json['dimensions']),
    warrantyInformation: json['warrantyInformation'] as String,
    shippingInformation: json['shippingInformation'] as String,
    availabilityStatus: json['availabilityStatus'] as String,
    reviewListDto:
        (json['reviews'] as List<dynamic>? ?? [])
            .map((e) => ReviewDto.fromJson(e))
            .toList(),
    returnPolicy: json['returnPolicy'] as String,
    minimumOrderQuantity: json['minimumOrderQuantity'] as int,
    meta: MetaDto.fromJson(json['meta']),
    images: List<String>.from(json['images'] ?? []),
    thumbnail: json['thumbnail'] as String,
  );

  static List<ProductDto> fromJsonDtoList(List<dynamic> jsonList) =>
      jsonList.map((json) => ProductDto.fromJson(json)).toList();
}
