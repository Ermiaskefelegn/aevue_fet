import '../../domain/domain.dart';
import '../data.dart';

class FavoriteRepository implements FavoriteRepositoryAbs {
  final FavoriteLocalDataSource favoriteLocalDataSource;

  FavoriteRepository({required this.favoriteLocalDataSource});

  @override
  Future<void> addTofavorite(FavoriteItem favoriteItem) async {
    try {
      final result = favoriteLocalDataSource.addToFavorite(favoriteItem);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> removeFromfavorite(int index) async {
    try {
      final result = favoriteLocalDataSource.removeFromFavorite(index);
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<FavoriteItem>> getfavoriteItems() async {
    try {
      final result = favoriteLocalDataSource.getFavoriteItems();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
