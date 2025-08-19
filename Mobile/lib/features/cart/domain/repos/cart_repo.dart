import 'package:unique/core/entities/poster_entity.dart';

import '../../presentation/widgets/cart_item.dart';

abstract class CartRepo {
  Future<void> addToCart(PosterEntity poster, {int quantity = 1});
  Future<void> removeFromCart(PosterEntity poster);
  Future<void> updateQuantity(PosterEntity poster, int quantity);
  Future<List<CartItem>> getCartItems();
  Future<void> clearCart();

  int get totalItems;
  double get totalPrice;
}
