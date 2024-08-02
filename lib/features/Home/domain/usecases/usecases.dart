import 'package:aevue_fet/features/Home/domain/entities/product.dart';
import 'package:aevue_fet/features/Home/domain/repositories/repositories.dart';

class FetchProducts {
  final ProductRepository repository;

  FetchProducts({required this.repository});

  Future<List<Product>> call(String query) {
    return repository.fetchProducts(query);
  }
}

class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<List<Product>> call(String query) {
    return repository.searchProducts(query);
  }
}
