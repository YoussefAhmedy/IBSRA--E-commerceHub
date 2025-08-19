import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unique/core/themes/app_colors.dart';
import 'package:unique/features/cart/presentation/widgets/cart_item.dart';
import '../controllers/cart_controller.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    return Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withAlpha(21)),
        borderRadius: BorderRadius.circular(14.5),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.5),
              child: Image.network(
                'http://localhost:3000/_next/image?url=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1541961017774-22349e4a1262%3Fw%3D500%26h%3D600%26fit%3Dcrop&w=1200&q=75',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.poster.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Size: ${item.poster.size}',
                          style: TextStyle(
                            color: Color(0xFF717182),
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => controller.removePoster(item.poster),
                      icon: Icon(
                        Icons.delete_outline,
                        size: 17.5,
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.poster.price}',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withAlpha(21)),
                        borderRadius: BorderRadius.circular(10.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () => controller.setQuantity(
                                item.poster,
                                item.quantity - 1,
                              ),
                              child: Icon(Icons.remove, size: 14.0),
                            ),
                            SizedBox(width: 21),
                            Text(
                              item.quantity.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.25,
                              ),
                            ),
                            SizedBox(width: 21),
                            GestureDetector(
                              onTap: () => controller.setQuantity(
                                item.poster,
                                item.quantity + 1,
                              ),
                              child: Icon(Icons.add, size: 14.0),
                            ),
                            SizedBox(width: 8.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
