import '../../presentation/widgets/cart_item.dart';
import '../repos/cart_repo.dart';

class GetCartUseCase {
  final CartRepo repository;

  GetCartUseCase(this.repository);

  Future<List<CartItem>> call() async {
    return await repository.getCartItems();
  }
}
