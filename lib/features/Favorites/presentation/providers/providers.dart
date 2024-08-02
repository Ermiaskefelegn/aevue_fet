import 'package:aevue_fet/features/Home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../favorites.dart';

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  return FavoriteRepository(
      favoriteLocalDataSource: FavoriteLocaldataSourceImpl(
          favoriteHiveHelper: FavoriteHiveHelper()));
});
final favoriteProvider =
    StateNotifierProvider<FavoriteManageController, FavoriteState>((ref) {
  final favoriteRepository = ref.watch(favoriteRepositoryProvider);
  return FavoriteManageController(favoriteRepository);
});

class FavoriteState {
  List<FavoriteItem> favoriteItems;

  FavoriteState(this.favoriteItems);
}

class FavoriteManageController extends StateNotifier<FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteManageController(this.favoriteRepository) : super(FavoriteState([]));

  Future<void> addToFavorite(
    Product product,
  ) async {
    final favoriteItem = FavoriteItem(
      product: product,
    );
    await favoriteRepository.addTofavorite(favoriteItem);
    final updatedfavoriteItems = await favoriteRepository.getfavoriteItems();
    state = FavoriteState(updatedfavoriteItems);
  }

  Future<void> removeFromFavorite(int index) async {
    await favoriteRepository.removeFromfavorite(index);
    final updatedfavoriteItems = await favoriteRepository.getfavoriteItems();
    state = FavoriteState(updatedfavoriteItems);
  }

  Future<void> getitems() async {
    final updatedfavoriteItems = await favoriteRepository.getfavoriteItems();
    state = FavoriteState(updatedfavoriteItems);
  }
}
