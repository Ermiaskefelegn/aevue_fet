import '../../domain/domain.dart';
import '../data.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> fetchProducts(String query) async {
    final productModel = await remoteDataSource.fetchProducts(query);
    return productModel.products
            ?.map((product) => Product(
                  id: product.id ?? 0,
                  title: product.title ?? "",
                  description: product.description ?? "",
                  price: product.price ?? 0,
                  image: product.images![0],
                ))
            .toList() ??
        [];
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    final productModel = await remoteDataSource.searchProducts(query);
    return productModel.products
            ?.map((productData) => Product(
                  id: productData.id!,
                  title: productData.title!,
                  description: productData.description!,
                  price: productData.price!,
                  image: productData.thumbnail!,
                ))
            .toList() ??
        [];
  }
}
