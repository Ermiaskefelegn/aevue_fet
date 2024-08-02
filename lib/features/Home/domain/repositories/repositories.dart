import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts(String query);
  Future<List<Product>> searchProducts(String query);
}
