import 'package:hive/hive.dart';

import '../../data.dart';

class FavoriteHiveHelper implements FavoriteLocalDataSource {
  Future<Box<FavoriteItem>> getfavoritebox() async {
    Box<FavoriteItem> box;
    box = await Hive.openBox<FavoriteItem>('favorites');
    return box;
  }

  @override
  @override
  Future<void> addToFavorite(FavoriteItem favoriteItem) async {
    final box = await getfavoritebox();
    box.add(favoriteItem);
  }

  @override
  Future<List<FavoriteItem>> getFavoriteItems() async {
    final box = await getfavoritebox();
    final favorite = box.values.toList();
    return favorite;
  }

  @override
  Future<void> removeFromFavorite(int index) async {
    final box = await getfavoritebox();
    box.deleteAt(index);
  }
}
