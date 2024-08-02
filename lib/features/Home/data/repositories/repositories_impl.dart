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
}
