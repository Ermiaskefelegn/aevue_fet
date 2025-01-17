import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../Favorites/favorites.dart';
import '../../home.dart';
import '../providers/search_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isInitialized = false;
    final searchQuery = ref.watch(searchQueryProvider);
    final productsAsyncValue = ref.watch(productProvider);
    final debouncedProductsAsyncValue = ref.watch(debouncedSearchProvider);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isInitialized) {
        ref.watch(favoriteProvider.notifier).getitems();
        isInitialized = true;
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Home'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
            ),
          ),
        ),
      ),
      body: searchQuery.isEmpty
          ? productsAsyncValue.when(
              data: (products) => ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final favoriteState =
                      ref.watch(favoriteProvider).favoriteItems;

                  bool isProductAlreadyFavorite() {
                    return favoriteState.any(
                        (element) => element.product.id == products[index].id);
                  }

                  final product = products[index];
                  return ProductTile(
                    isfavorite: isProductAlreadyFavorite(),
                    onpress: () {
                      if (isProductAlreadyFavorite()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          createSnackbarError(),
                        );
                      } else {
                        ref
                            .watch(favoriteProvider.notifier)
                            .addToFavorite(product);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(createSnackbarsuccess(width));
                      }
                    },
                    height: height / 8,
                    width: width / 4,
                    product: Product(
                      id: product.id,
                      title: product.title,
                      description: product.description,
                      price: product.price,
                      image: product.image,
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            )
          : debouncedProductsAsyncValue.when(
              data: (products) => ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final favoriteState =
                      ref.watch(favoriteProvider).favoriteItems;

                  bool isProductAlreadyFavorite() {
                    return favoriteState.any(
                        (element) => element.product.id == products[index].id);
                  }

                  final product = products[index];
                  return ProductTile(
                    isfavorite: isProductAlreadyFavorite(),
                    onpress: () {
                      if (isProductAlreadyFavorite()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          createSnackbarError(),
                        );
                      } else {
                        ref
                            .watch(favoriteProvider.notifier)
                            .addToFavorite(product);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(createSnackbarsuccess(width));
                      }
                    },
                    height: height / 8,
                    width: width / 4,
                    product: Product(
                      id: product.id,
                      title: product.title,
                      description: product.description,
                      price: product.price,
                      image: product.image,
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
    );
  }
}

SnackBar createSnackbarError() {
  return SnackBar(
    backgroundColor: Colors.red[100],
    content: const Row(
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: Colors.red,
        ),
        SizedBox(width: 20),
        Text(
          "This Item is already your Favorite",
          style: TextStyle(
            color: Color.fromARGB(255, 77, 75, 75),
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

SnackBar createSnackbarsuccess(double width) {
  return SnackBar(
    backgroundColor: Colors.green[100],
    content: Row(
      children: [
        const Icon(
          Icons.info_outline_rounded,
          color: Colors.green,
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: width / 1.4,
          child: const Text(
            "The Item is added to your Favourite Successfully",
            style: TextStyle(
              color: Color.fromARGB(255, 77, 75, 75),
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
