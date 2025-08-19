import 'package:unique/core/entities/poster_entity.dart';
import '../repos/cart_repo.dart';

class RemoveFromCartUseCase {
  final CartRepo repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(PosterEntity poster) async {
    await repository.removeFromCart(poster);
  }
}
