import 'package:get/get.dart';
import 'package:unique/core/entities/poster_entity.dart';
import 'package:unique/features/cart/presentation/controllers/cart_controller.dart';

class PosterDetailsController extends GetxController {
  final cartController = Get.find<CartController>();
  int quantity = 1;

  double price = 24.99;

  bool updateCart = false;

  double calculateTotalPrice() {
    return price * quantity;
  }

  void increaseQuantity() {
    quantity++;
    calculateTotalPrice();
    update();
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      calculateTotalPrice();
      update();
    }
  }

  void addToCart(PosterEntity poster) async {
    cartController.addPoster(poster, quantity: quantity);
    updateCart = true;
    update();
    await Future.delayed(const Duration(seconds: 2));
    updateCart = false;
    update();
  }
}
