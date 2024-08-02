import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isInitialized) {
        ref.watch(favoriteProvider.notifier).getitems();
        isInitialized = true;
      }
    });
    final favoriteState = ref.watch(favoriteProvider).favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: favoriteState.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: favoriteState.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                FavoritePageListTile(
                                  height: height / 8,
                                  width: width / 4,
                                  image: favoriteState[index]
                                      .product
                                      .image
                                      .toString(),
                                  title: favoriteState[index]
                                      .product
                                      .title
                                      .toString(),
                                  deletetap: () {
                                    ref
                                        .read(favoriteProvider.notifier)
                                        .removeFromFavorite(index);
                                  },
                                  price: double.parse(favoriteState[index]
                                          .product
                                          .price
                                          .toString())
                                      .toStringAsFixed(2),
                                  description: "",
                                ),
                                const Divider(
                                  color: Colors.grey,
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 30,
                      child: Icon(Icons.favorite),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "No products found.",
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "It seems that you have not added any products to your favourites list.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
