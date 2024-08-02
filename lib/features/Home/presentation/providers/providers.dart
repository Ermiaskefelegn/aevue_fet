import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Home.dart';

final productProvider = FutureProvider<List<Product>>((ref) async {
  final getProducts = ref.watch(getProductsProvider);
  return await getProducts("phone");
});

final getProductsProvider = Provider<FetchProducts>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return FetchProducts(repository: repository);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource: remoteDataSource);
});

final productRemoteDataSourceProvider =
    Provider<ProductRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductRemoteDataSourceImpl(dio: dio);
});

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});
