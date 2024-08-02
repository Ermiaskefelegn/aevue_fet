import 'package:dio/dio.dart';

import '../data.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> fetchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<ProductModel> fetchProducts(String query) async {
    final response =
        await dio.get('https://dummyjson.com/products/search?q=$query');
    if (response.statusCode == 200) {
      return ProductModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
