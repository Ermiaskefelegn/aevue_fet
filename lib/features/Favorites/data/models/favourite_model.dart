import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../Home/home.dart';
part 'favourite_model.g.dart';

@HiveType(typeId: 1)
class FavoriteItem extends Equatable {
  @HiveField(0)
  final Product product;

  const FavoriteItem({
    required this.product,
  });

  @override
  List<Object?> get props => [product];
}
