import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../Favorites/Favorites.dart';
import '../../Home.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteState = ref.watch(favoriteProvider).favoriteItems;

    final productsAsyncValue = ref.watch(productProvider);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: productsAsyncValue.when(
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            bool isProductAlreadyFavorite() {
              return favoriteState
                  .any((element) => element.product.id == products[index].id);
            }

            final product = products[index];
            return ProductTile(
                isfavorite: isProductAlreadyFavorite(),
                onpress: () {
                  if (isProductAlreadyFavorite()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[100],
                        content: const Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "This Item is already your Favorite",
                              style: TextStyle(
                                color: Color.fromARGB(255, 77, 75, 75),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    ref.watch(favoriteProvider.notifier).addToFavorite(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green[100],
                        content: Row(
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
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
                      ),
                    );
                  }
                },
                height: height / 8,
                width: width / 4,
                product: Product(
                    id: 0,
                    title: product.title,
                    description: product.description,
                    price: product.price,
                    image: product.image));
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
