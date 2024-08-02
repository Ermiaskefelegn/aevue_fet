import 'package:flutter/material.dart';

class FavoritePageListTile extends StatelessWidget {
  const FavoritePageListTile({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.deletetap,
    required this.height,
    required this.width,
  });
  final String image, title, price, description;
  final double height, width;
  final Function deletetap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        image,
        height: height,
        width: width,
      ),
      isThreeLine: true,
      minVerticalPadding: 1,
      title: SizedBox(
        width: 55,
        child: Text(
          title,
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
      ),
      trailing: Column(
        children: [
          Text(
            "£$price",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
          ),
          GestureDetector(
              onTap: () {
                deletetap();
              },
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: const Icon(Icons.delete)))
        ],
      ),
    );
  }
}
