import 'package:aevue_fet/core/constants.dart';
import 'package:aevue_fet/core/exception.dart';
import 'package:dio/dio.dart';

import '../data.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> fetchProducts(String query);
  Future<ProductModel> searchProducts(String query);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<ProductModel> fetchProducts(String query) async {
    try {
      final response = await dio.get('${Constants.baseUrl}$query');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<ProductModel> searchProducts(String query) async {
    try {
      final response = await dio.get('${Constants.baseUrl}$query');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load products');
      }
    } on DioException catch (e) {
      throw NetworkException.fromDioError(e);
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }
}
