import 'package:unique/core/entities/poster_entity.dart';

import '../../../../core/models/poster_model.dart';
import '../../../../core/services/cart_local_data_source.dart';
import '../../domain/repos/cart_repo.dart';
import '../../presentation/widgets/cart_item.dart';

class CartRepositoryImpl implements CartRepo {
  final CartLocalDataSource localDataSource;
  CartRepositoryImpl(this.localDataSource);

  @override
  Future<void> addToCart(PosterEntity poster, {int quantity = 1}) async {
    await localDataSource.addToCart(
      PosterModel.fromEntity(poster),
      quantity: quantity,
    );
  }

  @override
  Future<void> removeFromCart(PosterEntity poster) async {
    await localDataSource.removeFromCart(PosterModel.fromEntity(poster));
  }

  @override
  Future<void> updateQuantity(PosterEntity poster, int quantity) async {
    await localDataSource.updateQuantity(
      PosterModel.fromEntity(poster),
      quantity,
    );
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return localDataSource.items.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> clearCart() async {
    localDataSource.clear();
  }

  @override
  int get totalItems => localDataSource.totalItems;

  @override
  double get totalPrice => localDataSource.totalPrice;
}
