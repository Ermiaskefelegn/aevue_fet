import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import '../../home.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchProductsProvider = Provider(
  (ref) => SearchProducts(ref.watch(productRepositoryProvider)),
);

final debouncedSearchProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  const debounceDuration = Duration(milliseconds: 500);
  final searchProducts = ref.watch(searchProductsProvider);
  final streamController = StreamController<List<Product>>();

  Timer? debounceTimer;

  void searchProductsHandler(String query) async {
    if (query.isEmpty) {
      streamController.add([]);
      return;
    }
    try {
      final products = await searchProducts(query);
      streamController.add(products);
    } catch (e) {
      streamController.addError(e);
    }
  }

  void onQueryChanged(String query) {
    if (debounceTimer?.isActive ?? false) {
      debounceTimer?.cancel();
    }
    debounceTimer = Timer(debounceDuration, () => searchProductsHandler(query));
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
