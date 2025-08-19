import '../../features/cart/data/models/cart_item_model.dart';
import '../models/poster_model.dart';

class CartLocalDataSource {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  Future<void> addToCart(PosterModel poster, {int quantity = 1}) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final index = _items.indexWhere((item) => item.poster.id == poster.id);
    if (index != -1) {
      final newQty = _items[index].quantity + quantity;
      _items[index] = CartItemModel(
        poster: poster,
        quantity: newQty.clamp(1, 9999),
      );
    } else {
      _items.add(CartItemModel(poster: poster, quantity: quantity));
    }
  }

  Future<void> removeFromCart(PosterModel poster) async {
    await Future.delayed(const Duration(milliseconds: 150));
    _items.removeWhere((item) => item.poster.id == poster.id);
  }

  Future<void> updateQuantity(PosterModel poster, int quantity) async {
    await Future.delayed(const Duration(milliseconds: 150));
    final index = _items.indexWhere((item) => item.poster.id == poster.id);
    if (index == -1) return;
    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = CartItemModel(poster: poster, quantity: quantity);
    }
  }

  void clear() {
    _items.clear();
  }

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.poster.price * item.quantity);
}
