import 'package:get/get.dart';
import 'package:unique/core/entities/poster_entity.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_cart_item_quantity_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../widgets/cart_item.dart';

class CartController extends GetxController {
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartItemQuantityUseCase updateCartItemQuantityUseCase;
  final GetCartUseCase getCartUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartController({
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartItemQuantityUseCase,
    required this.getCartUseCase,
    required this.clearCartUseCase,
  });

  final RxList<CartItem> items = <CartItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();
  final RxDouble totalPrice = 0.0.obs;

  Future<void> loadCart() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final result = await getCartUseCase();
      items.assignAll(result);
      _recomputeTotal();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPoster(PosterEntity poster, {int quantity = 1}) async {
    try {
      await addToCartUseCase(poster, quantity: quantity);
      await loadCart();
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> removePoster(PosterEntity poster) async {
    try {
      await removeFromCartUseCase(poster);
      await loadCart();
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> setQuantity(PosterEntity poster, int quantity) async {
    try {
      await updateCartItemQuantityUseCase(poster, quantity);
      await loadCart();
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> clear() async {
    try {
      await clearCartUseCase();
      await loadCart();
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  void _recomputeTotal() {
    totalPrice.value = items.fold(0.0, (sum, i) => sum + i.totalPrice);
  }
}
