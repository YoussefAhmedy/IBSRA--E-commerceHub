import '../repos/cart_repo.dart';

class ClearCartUseCase {
  final CartRepo repository;

  ClearCartUseCase(this.repository);

  Future<void> call() async {
    await repository.clearCart();
  }
}
