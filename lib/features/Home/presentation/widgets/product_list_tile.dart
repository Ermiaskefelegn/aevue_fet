import 'package:flutter/material.dart';

import '../../Home.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final double height, width;
  final Function onpress;
  final bool isfavorite;
  const ProductTile(
      {super.key,
      required this.product,
      required this.height,
      required this.width,
      required this.onpress,
      required this.isfavorite});

  @override
  Widget build(BuildContext context) {
    double tilewidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(vertical: height / 30),
      margin:
          EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: ExpansionTile(
        shape: const Border(),
        tilePadding: EdgeInsets.symmetric(horizontal: tilewidth / 30),
        leading: Image.network(
          product.image,
          height: height,
          width: width,
        ),
        title: Text(product.title),
        trailing: Text('\$${product.price}'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: tilewidth / 1.3, child: Text(product.description)),
                IconButton(
                    onPressed: () {
                      onpress();
                    },
                    icon: isfavorite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
