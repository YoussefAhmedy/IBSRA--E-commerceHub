import 'package:unique/core/entities/poster_entity.dart';

class CartItem {
  final PosterEntity poster;
  final int quantity;

  const CartItem({
    required this.poster,
    required this.quantity,
  });

  double get totalPrice => poster.price * quantity;

  CartItem copyWith({
    String? id,
    PosterEntity? poster,
    int? quantity,
  }) {
    return CartItem(
      poster: poster ?? this.poster,
      quantity: quantity ?? this.quantity,
    );
  }
}
