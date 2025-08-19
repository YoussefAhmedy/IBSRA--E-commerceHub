import 'package:unique/core/entities/poster_entity.dart';

import '../repos/cart_repo.dart';

class AddToCartUseCase {
  final CartRepo repository;

  AddToCartUseCase(this.repository);

  Future<void> call(PosterEntity poster, {int quantity = 1}) async {
    await repository.addToCart(poster, quantity: quantity);
  }
}
