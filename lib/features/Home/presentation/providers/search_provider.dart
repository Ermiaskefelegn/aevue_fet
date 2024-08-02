import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'dart:async';

import '../../Home.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final debouncedSearchProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  const debounceDuration = Duration(milliseconds: 500);
  final streamController = StreamController<List<Product>>();

  Timer? debounceTimer;

  void searchProducts(String query) async {
    if (query.isEmpty) {
      streamController.add([]);
      return;
    }
    try {
      final response =
          await Dio().get('https://dummyjson.com/products/search?q=$query');
      final productModel = ProductModel.fromJson(response.data);
      final List<Product> products = productModel.products!
          .map((productData) => Product(
                id: productData.id!,
                title: productData.title!,
                description: productData.description!,
                price: productData.price!,
                image: productData.thumbnail!,
              ))
          .toList();
      streamController.add(products);
    } catch (e) {
      streamController.addError(e);
    }
  }

  void onQueryChanged(String query) {
    if (debounceTimer?.isActive ?? false) {
      debounceTimer?.cancel();
    }
    debounceTimer = Timer(debounceDuration, () => searchProducts(query));
  }

  ref.listen<String>(searchQueryProvider, (_, next) {
    onQueryChanged(next);
  });

  ref.onDispose(() {
    debounceTimer?.cancel();
    streamController.close();
  });

  return streamController.stream;
});
