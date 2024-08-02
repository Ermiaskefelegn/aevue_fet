import '../../data/data.dart';

abstract class FavoriteRepositoryAbs {
  Future<void> addTofavorite(FavoriteItem favoriteItem);
  Future<void> removeFromfavorite(int index);
  Future<List<FavoriteItem>> getfavoriteItems();
}
