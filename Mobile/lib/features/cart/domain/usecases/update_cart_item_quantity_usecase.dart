import 'package:unique/core/entities/poster_entity.dart';

import '../repos/cart_repo.dart';

class UpdateCartItemQuantityUseCase {
  final CartRepo repository;

  UpdateCartItemQuantityUseCase(this.repository);

  Future<void> call(PosterEntity poster, int quantity) async {
    await repository.updateQuantity(poster, quantity);
  }
}
