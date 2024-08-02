import 'package:aevue_fet/core/exception.dart';

import '../../data.dart';

abstract class FavoriteLocalDataSource {
  Future<void> addToFavorite(FavoriteItem favoriteItem);
  Future<void> removeFromFavorite(int index);
  Future<List<FavoriteItem>> getFavoriteItems();
}

class FavoriteLocaldataSourceImpl implements FavoriteLocalDataSource {
  final FavoriteHiveHelper favoriteHiveHelper;

  FavoriteLocaldataSourceImpl({required this.favoriteHiveHelper});
  @override
  Future<void> addToFavorite(FavoriteItem favoriteItem) async {
    final favorites = await favoriteHiveHelper.addToFavorite(favoriteItem);
    try {
      return favorites;
    } catch (e) {
      throw CacheException(message: 'No favorites found');
    }
  }

  @override
  Future<List<FavoriteItem>> getFavoriteItems() async {
    final favorites = await favoriteHiveHelper.getFavoriteItems();
    try {
      return favorites;
    } catch (e) {
      throw CacheException(message: 'No favorites found');
    }
  }

  @override
  Future<void> removeFromFavorite(int index) async {
    final carts = await favoriteHiveHelper.removeFromFavorite(index);
    try {
      return carts;
    } catch (e) {
      throw CacheException(message: 'No favorites found');
    }
  }
}
