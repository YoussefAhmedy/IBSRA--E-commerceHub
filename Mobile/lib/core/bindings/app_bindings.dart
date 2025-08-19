import 'package:get/get.dart';
import 'package:unique/core/services/cart_local_data_source.dart';
import 'package:unique/features/cart/data/repos_impl/cart_repository_impl.dart';
import 'package:unique/features/cart/domain/repos/cart_repo.dart';
import 'package:unique/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:unique/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:unique/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:unique/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:unique/features/cart/domain/usecases/update_cart_item_quantity_usecase.dart';
import 'package:unique/features/cart/presentation/controllers/cart_controller.dart';
import 'package:unique/features/create_custom_poster/presentation/controllers/create_poster_controller.dart';
import 'package:unique/features/main/presentation/controllers/main_page_controller.dart';
import 'package:unique/features/poster_details/presentation/controllers/poster_details_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(() => MainPageController());
    Get.put(CreatePosterController(), permanent: true);
    Get.put(CartLocalDataSource());
    Get.put<CartRepo>(CartRepositoryImpl(Get.find<CartLocalDataSource>()));
    Get.put(AddToCartUseCase(Get.find<CartRepo>()));
    Get.put(RemoveFromCartUseCase(Get.find<CartRepo>()));
    Get.put(UpdateCartItemQuantityUseCase(Get.find<CartRepo>()));
    Get.put(GetCartUseCase(Get.find<CartRepo>()));
    Get.put(ClearCartUseCase(Get.find<CartRepo>()));
    Get.put(
      CartController(
        addToCartUseCase: Get.find<AddToCartUseCase>(),
        removeFromCartUseCase: Get.find<RemoveFromCartUseCase>(),
        updateCartItemQuantityUseCase:
            Get.find<UpdateCartItemQuantityUseCase>(),
        getCartUseCase: Get.find<GetCartUseCase>(),
        clearCartUseCase: Get.find<ClearCartUseCase>(),
      ),
    );

    Get.put(PosterDetailsController());
  }
}
