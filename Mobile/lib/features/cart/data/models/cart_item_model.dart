import '../../../../core/models/poster_model.dart';
import '../../presentation/widgets/cart_item.dart';

class CartItemModel {
  final PosterModel poster;
  final int quantity;

  CartItemModel({required this.poster, this.quantity = 1});

  factory CartItemModel.fromEntity(CartItem cartItem) => CartItemModel(
    poster: PosterModel.fromEntity(cartItem.poster),
    quantity: cartItem.quantity,
  );

  CartItem toEntity() => CartItem(
    poster: poster.toEntity(),
    quantity: quantity,
  );
}
